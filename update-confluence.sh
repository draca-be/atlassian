#!/bin/sh

VERSION=$@

git checkout master &&
    sed -i "s/CONF_VERSION=.*/CONF_VERSION=$@/g" atlassian-confluence*/Dockerfile &&
    git add atlassian-confluence*/Dockerfile &&
    git commit -m "Update Confluence $@" &&
    git tag -f confluence-$@
