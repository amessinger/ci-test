LAST_COMMIT_MESSAGE=$(shell git log -1 --pretty=%B)

install:
	echo "# Installing"
	echo "Last message: $(LAST_COMMIT_MESSAGE)"

build:
	echo "# Building"

test:
	echo "# Running tests"
