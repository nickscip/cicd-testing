# Sem-Verified CI
Workflows to automatically release Semantically Versioned Code

## Prerequisites
You will need the following tools to use the resources in this repo:
- [Git-Cliff](https://github.com/orhun/git-cliff): A CLI that automatically generates change-logs from your commit history.
- [GitHub Actions](https://docs.github.com/en/actions/about-github-actions/understanding-github-actions): A CI pipeline written in .yaml that triggers upon GitHub events.
- [Git-commit](https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/git-commit/README.md) (optional): A terminal plugin that makes writing conventional commits a breeze.
- [Poetry](https://python-poetry.org/) (optional): A better Python package manager than Conda.

## I. Quickstart

### I.a Use the GitHub Workflow
The file `.github/workflows/release.yml` contains a GitHub workflow that will do the following:
1. Update a CHANGELOG.md file in your repository.
2. Update any references to the Version number in your repo.
3. Commit and push these changes.
4. Upload a new GitHub Release and git tag.

You must have a `main` branch where your latest release is deployed. Your `main` branch must also have access to the latest git tag because that is how `git-cliff` calculates its version bump.

To set `secrets.GH_TOKEN`:
1. Go to your GitHub profile's developer settings and generate a new personal access token with codebase access.
2. Go to your repo's settings and add a secret and set the value as the token.

### I.b Use the Bash Script
If you prefer not to use the workflow, I have provided the script `bump_version.sh` that can be ran manually or added to a `pre-commit` pipeline.

## II. Caveat
If your repository has branch permissions set to not allow direct pushes to `main`, you might have to use an admin or machine user's credentials. If that is not possible, another solution is to create a GitHub Application, which is out-of-scope for this project. Instead, 