# Atlassian Confluence

[![Docker Pulls](https://img.shields.io/docker/pulls/draca/atlassian-confluence.svg)](https://hub.docker.com/r/draca/atlassian-confluence/)
[![Build Status](https://img.shields.io/docker/build/draca/atlassian-confluence.svg)](https://hub.docker.com/r/draca/atlassian-confluence/builds/)
[![Docker Stars](https://img.shields.io/docker/stars/draca/atlassian-confluence.svg)](https://hub.docker.com/r/draca/atlassian-confluence/)

This image enables you to run [Atlassian Confluence](https://www.atlassian.com/software/confluence).
It is based on [alpine-java](https://hub.docker.com/r/anapsix/alpine-java/) to provide an as small as possible image.

# Versions

Only 6.5.0 or newer images exist. If you have need for an older one you can take the Dockerfile and edit
the $CONF_VERSION environment variable to suit your needs. This will work a number of versions back up
until the download URL was changed.

# Environment variables

A number of environment variables are supported.

## Run as non-root

By default the application runs as a non-root user. You can influence which user by setting these variables.
Note that the names need to be known inside the container so results might not be what you expect.

* RUN_USER
* RUN_GROUP

## Run behind a proxy

If you are running the application behind a reverse proxy you need to set these variables so that it knows
where to redirect requests to.

* CONF_PROXY_NAME : the hostname (for example jira.mycompany.com)
* CONF_PROXY_PORT : the port (for example 80 or 443)
* CONF_PROXY_SCHEME : either http or https
* CONF_CONTEXT_PATH : if the application isn't running on the root path (for example mycompany.com/jira: set this to jira)

## Disable mail

If you want to disable the incoming and outgoing mail on for example a staging server set DISABLE_NOTIFICATIONS
to TRUE

## Memory

Change the default JVM memory size

* JVM_MINIMUM_MEMORY
* JVM_MAXIMUM_MEMORY

## Additional JVM args

If you need to pass additional args you can set the CONF_ARGS variable.

# Volumes

If you want to mount a volume or a directory to store your data outside of the container you should
mount it over /opt/atlassian/confluence/data

# Usage

Example:

    docker run -it --rm draca/atlassian-confluence -p 8090:8090

A very quick docker-compose file could be:

```
version: '3'
services:
  confluence:
    image: draca/atlassian-confluence
    environment:
      - DISABLE_NOTIFICATIONS=TRUE
      - CONF_ARGS="-Datlassian.plugins.enable.wait=300"
    volumes:
      - ./data:/opt/atlassian/confluence/data
    ports:
      - 8090:8090

  confluencedb:
    image: postgres:9.6
    environment:
      - POSTGRES_PASSWORD=secret
      - POSTGRES_USER=confluence
      - POSTGRES_DB=confluence
    volumes:
      - ./db:/var/lib/postgresql/data
```

# Disclaimer

A lot of care was taking in creating these images however running them is at your own risk and no claims can
be made should data loss occur. By using these images you confirm that you are complying by any and all of
the licenses of the 3rd party software included in this build.
