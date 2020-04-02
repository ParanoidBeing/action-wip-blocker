#!/bin/bash

set -e

# skip if not a PR
echo "Checking if a PR command..."
(jq .)
echo $GITHUB_EVENT_PATH
(jq -r ".pull_request.url" "$GITHUB_EVENT_PATH") || exit 78

# Block if wip found in title
echo "Checking if contains WIP ..."
(jq .)
(jq -r ".pull_request.title" "$GITHUB_EVENT_PATH" | grep -E "wip") exit 1 && exit 0
