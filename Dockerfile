FROM alpine:latest

LABEL repository="https://github.com/ParanoidBeing/action-wip-blocker"
LABEL homepage="https://github.com/ParanoidBeing/action-wip-blocker"
LABEL "com.github.actions.name"="Block WIP"
LABEL "com.github.actions.description"="Block PRs that are WIP"
LABEL "com.github.actions.icon"="alert-octagon"
LABEL "com.github.actions.color"="gray-dark"

RUN apk --no-cache add jq bash curl git

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
