FROM zabbix/zabbix-proxy-sqlite3:centos-5.0-latest
USER root

ARG YUM_FLAGS_COMMON="-y"
ARG YUM_FLAGS_PERSISTENT="${YUM_FLAGS_COMMON}"

RUN set -eux && \	
    yum ${YUM_FLAGS_PERSISTENT} install epel-release && \
    yum ${YUM_FLAGS_PERSISTENT} install zeromq python3-pip && \
    yum ${YUM_FLAGS_PERSISTENT} clean all && \
    rm -rf /var/cache/yum/ 

EXPOSE 10123/TCP
EXPOSE 10124/TCP
EXPOSE 9999/TCP
EXPOSE 10000/TCP

WORKDIR /var/lib/zabbix
ADD vpoller_module.conf /etc/zabbix/
ADD vpoller.so builds/vpoller.so 

USER 1997