#!/bin/bash

set -e

# skip if not a PR
echo "Checking if a PR command..."
(jq -r ".pull_request.url" "$GITHUB_EVENT_PATH") || exit 78

#printing labels
(jq -r ".pull_request.labels" "$GITHUB_EVENT_PATH") 

# Block if wip found in title
echo "Checking wip mentions in title ..."
result=$(jq -r ".pull_request.title" "$GITHUB_EVENT_PATH")
if [[ $result =~ "wip" ]]
then
   exit 1
else
   exit 0
fi
