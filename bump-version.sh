# This script bumps the project's version number, creates a new tag, and updates the CHANGELOG.md file.
#!/bin/bash

set -e

if ! [ -x "$(command -v git-cliff)" ]; then
        echo 'Error: git-cliff is not installed.' >&2
        exit 1
fi

if ! [ -x "$(command -v poetry)" ]; then
        echo 'Error: poetry is not installed.' >&2
        exit 1
fi

if ! [ -x "$(command -v gh)" ]; then
        echo 'Error: gh is not installed.' >&2
        exit 1
fi

git checkout main
git pull

echo "Generating changelog"
git cliff --verbose --bump -o CHANGELOG.md

NEW_TAG=$(git cliff --bumped-version)
echo "NEW_TAG=$NEW_TAG"

poetry version "$NEW_TAG"

git add -A
git commit -m "Update changelog"
git push

# echo "Creating GitHub release for tag $NEW_TAG"
# gh release create "$NEW_TAG" -F CHANGELOG.md -t "$NEW_TAG" --repo "$GITHUB_REPOSITORY" --generate-notes

echo "Updating dev branch"
git pull
git checkout dev
git rebase main
git push

echo "Script completed successfully!"
