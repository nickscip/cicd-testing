#!/bin/bash

set -euo pipefail

error_exit() {
        echo "$1" 1>&2
        exit 1
}

for cmd in git-cliff poetry gh; do
    if ! command -v "$cmd" &>/dev/null; then
        error_exit "$cmd not installed."
    fi
done

git checkout main
git pull

echo "Generating changelog"
git cliff --verbose --bump -o CHANGELOG.md

NEW_TAG=$(git cliff --bumped-version)
echo "NEW_TAG=$NEW_TAG"

poetry version "$NEW_TAG"

git add CHANGELOG.md pyproject.toml
git commit -m "chore(release): prepare changelog for $NEW_TAG"
git push

git tag "$NEW_TAG"
git push --tags

echo "Creating GitHub release for tag $NEW_TAG"
gh release create "$NEW_TAG" -t "$NEW_TAG" --generate-notes

echo "Updating dev branch"
git checkout dev
git pull --rebase
git push

echo "Script completed successfully!"
