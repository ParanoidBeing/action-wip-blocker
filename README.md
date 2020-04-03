# Auto Block WIP PRs 

A GitHub Action that blocks PRs that are tagged by WIP (et al) or have WIP in their title. A fail fast method to remind the reviewer that the current PR is still a work in progress and should not be merged.

Scans labels and title of the PR and fails if it encounters any of the blocked words in them.

## Usage

If this solves your problems adding it to your project is straightforward 

```workflow
name: WIP Checker

on:
  pull_request:
    branches:
    - development
    types: [labeled, unlabeled, edited, opened, synchronize, reopened]

jobs:
  check_wip:
    runs-on: ubuntu-latest
    steps:
    - name: Block if WIP PR
      uses: ParanoidBeing/action-wip-blocker@v0.1.1
      env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
          BLOCK_LIST: "WIP|do not merge|backend not live"
```

Depending on your project's requrirements you may add / remove triggers and/or branches [Pull request events](https://help.github.com/en/articles/events-that-trigger-workflows#pull-request-event-pull_request)

