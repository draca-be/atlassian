#!/bin/bash

if [ -n "${JIRA_PROXY_NAME}" ]; then
    sed -i "s/port=\"8080\"/port=\"8080\" proxyName=\"${JIRA_PROXY_NAME}\"/g" "${JIRA_INSTALL}/conf/server.xml"
fi
if [ -n "${JIRA_PROXY_PORT}" ]; then
    sed -i "s/port=\"8080\"/port=\"8080\" proxyPort=\"${JIRA_PROXY_PORT}\"/g" "${JIRA_INSTALL}/conf/server.xml"
fi
if [ -n "${JIRA_PROXY_SCHEME}" ]; then
    sed -i "s/port=\"8080\"/port=\"8080\" scheme=\"${JIRA_PROXY_SCHEME}\"/g" "${JIRA_INSTALL}/conf/server.xml"
fi
if [ -n "${JIRA_CONTEXT_PATH}" ]; then
    sed -i "s:path=\"\":path=\"${JIRA_CONTEXT_PATH}\"/g" "${JIRA_INSTALL}/conf/server.xml"
fi

if [ -n "${DISABLE_NOTIFICATIONS}" ]; then
    sed -i "s/\#DISABLE_NOTIFICATIONS/DISABLE_NOTIFICATIONS/g" "${JIRA_INSTALL}/bin/setenv.sh"
fi

if [ -n "${JVM_MINIMUM_MEMORY}" ]; then
    sed -i "s/JVM_MINIMUM_MEMORY=\".*\"/JVM_MINIMUM_MEMORY=\"${JVM_MINIMUM_MEMORY}\"/g" "${JIRA_INSTALL}/bin/setenv.sh"
fi

if [ -n "${JVM_MAXIMUM_MEMORY}" ]; then
    sed -i "s/JVM_MAXIMUM_MEMORY=\".*\"/JVM_MAXIMUM_MEMORY=\"${JVM_MAXIMUM_MEMORY}\"/g" "${JIRA_INSTALL}/bin/setenv.sh"
fi

if [ -n "${JIRA_ARGS}" ]; then
    sed -i "s/JVM_SUPPORT_RECOMMENDED_ARGS=\"\"/JVM_SUPPORT_RECOMMENDED_ARGS=\"${JIRA_ARGS}\"/g" \
        "${JIRA_INSTALL}/bin/setenv.sh"
fi

chown -R ${RUN_USER}:${RUN_GROUP} "${JIRA_INSTALL}" "${JIRA_HOME}"

sed -i "s/JIRA_USER=\"\"/JIRA_USER=\"${RUN_USER}\"/g" "${JIRA_INSTALL}/bin/user.sh"

exec "$@"
