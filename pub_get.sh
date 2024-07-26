#!/bin/bash

# Find all directories containing a pubspec.yaml file
PROJECT_DIRS=$(find . -name "pubspec.yaml" -exec dirname {} \;)

# Loop through each directory and run 'pub get'
for DIR in $PROJECT_DIRS; do
  echo "Running 'pub get' in $DIR"
  (cd "$DIR" && flutter pub get || pub get)
done

echo "Completed 'pub get' in all Dart/Flutter project directories."