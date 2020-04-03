#!/bin/bash

set -e

#Making sure we have the token
if [[ -z "$GITHUB_TOKEN" ]]; then
  echo "Set the GITHUB_TOKEN env variable."
  exit 1
fi

# skip if not a PR
echo "Checking if a PR command..."
(jq -r ".pull_request.url" "$GITHUB_EVENT_PATH") || exit 78

#Setting Required Headers
API_HEADER="Accept: application/vnd.github.v3+json; application/vnd.github.antiope-preview+json"
AUTH_HEADER="Authorization: token ${GITHUB_TOKEN}"

#Extracting pull request number
number=$(jq -r ".pull_request.number" "$GITHUB_EVENT_PATH")

#Calling the PR API to fetch latest info
#If the action had intially failed due to addition of a label or editing the title, it should pass if manually re-triggered
#later on, so we need to always work on the latest information.
RESPONSE=$(curl -s \
    -H "Content-Type: application/json" \
    -H "${AUTH_HEADER}" \
    -H "${API_HEADER}" \
    "https://api.github.com/repos/${GITHUB_REPOSITORY}/pulls/${number}")


#Extracting Title & Lables
title=$(jq ".title" <<< "$RESPONSE")
labels=$(jq ".labels" <<< "$RESPONSE")

#Block if suspect words are found.
#Todo - words to be provided as action input.
checkForBlockingWords(){
    if  echo "${1}  ${2}" | grep -iE 'WIP|do not merge|backend not live'
    then
       return 1
    else
       return 0
    fi
}

checkForBlockingWords "$title" "$labels"
