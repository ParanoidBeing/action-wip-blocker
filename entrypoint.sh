#!/bin/bash

set -e

# skip if not a PR
echo "Checking if a PR command..."
(jq -r ".pull_request.url" "$GITHUB_EVENT_PATH") || exit 78

title=$(jq -r ".pull_request.title" "$GITHUB_EVENT_PATH")
labels=$(jq -r ".pull_request.labels" "$GITHUB_EVENT_PATH")

checkForBlockingWords(){
    if echo $1 | grep -iE 'WIP|do not merge|backend not live'
    then
       exit 1
    else
       exit 0
    fi
}
checkForBlockingWords "$title"
checkForBlockingWords "$labels"
