REPOSITORY_NAME=ci-test
DIST_FOLDER=dist/
LAST_COMMIT_MESSAGE=$(shell git log -1 --pretty=%B)
TAG_FORMAT=^[0-9.]\+$
IS_TAG=$(shell echo "$(LAST_COMMIT_MESSAGE)" | grep -c "$(TAG_FORMAT)")
ARCHIVE_NAME=$(REPOSITORY_NAME)-$(LAST_COMMIT_MESSAGE).tag.gz

install:
	echo "# Installing"

build:
	echo "# Building"

release:
	./release.sh


test:
	echo "# Running tests"
