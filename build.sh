#!/bin/sh

FOLDER="$1"
CHANGABLE_FILE="package.json"

cd $FOLDER

git reset --hard HEAD || echo "Unable to reset"
git pull

# Getting changed file
FILE="$(git diff --name-only HEAD~1 | grep $CHANGABLE_FILE)"

if [ "$FILE" = "$CHANGABLE_FILE" ]; then
	npm ci
fi

npm run build

cp -rf build/* ../public/$FOLDER
cp -rf ../public/$FOLDER/static/* ../public/static || echo "Not moving"
