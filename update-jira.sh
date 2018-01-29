#!/bin/sh

VERSION=$@

git checkout master &&
    sed -i "s/JIRA_VERSION=.*/JIRA_VERSION=$@/g" atlassian-jira*/Dockerfile &&
    git add atlassian-jira*/Dockerfile &&
    git commit -m "Update JIRA $@" &&
    git tag -f jira-$@
