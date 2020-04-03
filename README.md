# Auto Block WIP PRs 

A GitHub Action that blocks PRs that are tagged by WIP (et al) or have WIP in their title. A fail fast method to remind the reviewer that the current PR is still a work in progress and should not be merged.

Works on labels and titles as of now. Currently, the set of blocked words are limited. Open to PRs / Improvements.

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
      uses: ParanoidBeing/action-wip-blocker@v0.1.0
      env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

Depending on your project's requrirements you may add / remove triggers and/or branches [Pull request events](https://help.github.com/en/articles/events-that-trigger-workflows#pull-request-event-pull_request)

