#!/bin/bash

# GITHUB SETTINGS
REPOSITORY_OWNER="amessinger"
REPOSITORY_NAME="ci-test"
OAUTH_TOKEN="fa34424f0e525ae4180afe7f21e02382dca4f5f7"

# ARCHIVE SETTINGS
DIST_FOLDER="dist/"

# TAG SETTINGS
LAST_COMMIT_MESSAGE=`git log -1 --pretty=%B`
TAG_FORMAT="^[0-9.]\+$"
TAG=`echo $LAST_COMMIT_MESSAGE | grep $TAG_FORMAT`

if [ -z $TAG ]; then
	echo "No need for release"
else
	echo "Let's release tag $TAG"

	# ARCHIVE CREATION
	archive_name=$REPOSITORY_NAME-$TAG.tag.gz
	echo "Creating archive $archive_name from folder $DIST_FOLDER"
	tar zcvf $archive_name $DIST_FOLDER

	# RELEASE CREATION
	releases_url="https://api.github.com/repos/$REPOSITORY_OWNER/$REPOSITORY_NAME/releases"
	echo "Creating release, posting at $releases_url"
	response=`curl --header "Authorization: token $OAUTH_TOKEN" --request POST --data '{"tag_name":"'"$TAG"'"}' "$releases_url"`
	echo $response

	# ARCHIVE TO RELEASE
	upload_url=`echo $response | grep -Po '"upload_url":.*?[^\\\]",' | cut -d ':' -f 2- | tail -c +3 | head -c -16`
	echo "Adding archive, posting at $upload_url"
	curl --header "Authorization: token $OAUTH_TOKEN" --header "Content-Type: application/zip" --data-binary @$archive_name "$upload_url?name=$archive_name"
fi
