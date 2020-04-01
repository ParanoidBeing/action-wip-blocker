#!/bin/bash

set -e

# skip if not a PR
echo "Checking if a PR command..."
(jq .)
(jq -r ".pull_request.url" "$GITHUB_EVENT_PATH") || exit 78

# skip if no /revert
echo "Checking if contains '/revert' command..."
(jq .)
(jq -r ".pull_request.title" "$GITHUB_EVENT_PATH" | grep -E "wip") || exit 78
