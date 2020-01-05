#!/bin/bash

# fail if any commands fails
set -e
# debug log
set -x

# Tools
update_tag() {
  if git tag --list | grep $1 >/dev/null 2>&1
  then
    echo "Found tag: $1, removing..."
    git tag -d $1
    git push origin :refs/tags/$1
  fi
  git tag -a $1 -m "$1" -f
  git push origin $1 -f
}

# Env
PROJECT_NAME='AltyCore'
PODSPEC_FILE="$PROJECT_NAME.podspec"

# Get framework plist file
PLIST_PATH="./$PROJECT_NAME/Supporting/Info.plist"
if [ ! -f "$PLIST_PATH" ]; then 
  echo "Plist file at $PLIST_PATH not found, running not from project root? Exiting..."
  exit 1
fi

# Get framework version
VERSION_NUMBER=`sed -n '/MARKETING_VERSION/{s/MARKETING_VERSION = //;s/;//;s/^[[:space:]]*//;p;q;}' ./$PROJECT_NAME.xcodeproj/project.pbxproj`
BUILD_NUMBER=`sed -n '/CURRENT_PROJECT_VERSION/{s/CURRENT_PROJECT_VERSION = //;s/;//;s/^[[:space:]]*//;p;q;}' ./$PROJECT_NAME.xcodeproj/project.pbxproj`
echo "Current version: $VERSION_NUMBER ($BUILD_NUMBER), using $VERSION_NUMBER as a tag"

# Write version to podspec
sed -i '' "s/\(spec.version *= *\)\"[^\"]*\"/\1\"${VERSION_NUMBER}\"/" "${PODSPEC_FILE}"

# Update Core repo tag
update_tag $VERSION_NUMBER

# Clone podspec repo
TRUNK_DIR=/tmp/spec-repo
if [ -d "$TRUNK_DIR" ]; then rm -Rf $TRUNK_DIR; fi
git clone git@bitbucket.org:alterplay/alty-ios-podspecs.git $TRUNK_DIR

# Add directory with tag name, copy podspec, push
TAG_DIR="$TRUNK_DIR/Specs/$PROJECT_NAME/$VERSION_NUMBER"
if [ ! -d "$TAG_DIR" ]; then 
  mkdir $TAG_DIR
  cp ./$PODSPEC_FILE $TAG_DIR
  cd $WORKING_DIR
  git add .
  git commit -am "$VERSION_NUMBER"
  # git push origin master
else
  echo "Directory for $VERSION_NUMBER" exists in trunk repo, skipping...
fi

