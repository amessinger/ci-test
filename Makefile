PROJECT_NAME=volzord
DIST_FOLDER=dist/
LAST_COMMIT_MESSAGE=$(shell git log -1 --pretty=%B)
TAG_FORMAT=^[0-9.]\+$
IS_TAG=$(shell echo "$(LAST_COMMIT_MESSAGE)" | grep -c "$(TAG_FORMAT)")

install:
	echo "# Installing"

build:
	echo "# Building"

release:
ifeq ($(IS_TAG), 1)
	echo "Let's release tag $(LAST_COMMIT_MESSAGE)"
	tar zcvf $(PROJECT_NAME)-$(LAST_COMMIT_MESSAGE).tag.gz $(DIST_FOLDER)
else
	echo "No need for release"
endif


test:
	echo "# Running tests"
