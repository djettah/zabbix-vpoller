FROM zabbix/zabbix-server-pgsql:centos-5.0-latest
USER root 
ARG YUM_FLAGS_COMMON="-y"
ARG YUM_FLAGS_PERSISTENT="${YUM_FLAGS_COMMON}"

RUN set -eux && \
    yum ${YUM_FLAGS_COMMON} makecache && \
    yum ${YUM_FLAGS_PERSISTENT} install \
            python3-pip && \
    yum ${YUM_FLAGS_PERSISTENT} clean all && \
    pip3 install py-zabbix
    
USER 1997