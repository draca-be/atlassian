#!/bin/bash

if [ -n "${CONF_PROXY_NAME}" ]; then
    sed -i "s/port=\"8090\"/port=\"8090\" proxyName=\"${CONF_PROXY_NAME}\"/g" "${CONF_INSTALL}/conf/server.xml"
fi
if [ -n "${CONF_PROXY_PORT}" ]; then
    sed -i "s/port=\"8090\"/port=\"8090\" proxyPort=\"${CONF_PROXY_PORT}\"/g" "${CONF_INSTALL}/conf/server.xml"
fi
if [ -n "${CONF_PROXY_SCHEME}" ]; then
    sed -i "s/port=\"8090\"/port=\"8090\" scheme=\"${CONF_PROXY_SCHEME}\"/g" "${CONF_INSTALL}/conf/server.xml"
fi
if [ -n "${CONF_CONTEXT_PATH}" ]; then
    sed -i "s:path=\"\":path=\"${CONF_CONTEXT_PATH}\"/g" "${CONF_INSTALL}/conf/server.xml"
fi

if [ -n "${DISABLE_NOTIFICATIONS}" ]; then
    CONF_ARGS="-Datlassian.mail.senddisabled=true -Datlassian.mail.fetchdisabled=true -Datlassian.mail.popdisabled=true ${CONF_ARGS}"
fi

sed -i "s/-Xms[0-9]\+[kmg] -Xmx[0-9]\+[kmg]/-Xms${JVM_MINIMUM_MEMORY} -Xmx${JVM_MAXIMUM_MEMORY} ${CONF_ARGS}/g" "${CONF_INSTALL}/bin/setenv.sh"

chown -R ${RUN_USER}:${RUN_GROUP} "${CONF_INSTALL}" "${CONF_HOME}"

sed -i "s/CONF_USER=\"\"/CONF_USER=\"${RUN_USER}\"/g" "${CONF_INSTALL}/bin/user.sh"

exec "$@"
