FROM zabbix/zabbix-proxy-sqlite3:centos-4.4-latest

ARG YUM_FLAGS_COMMON="-y"
ARG YUM_FLAGS_PERSISTENT="${YUM_FLAGS_COMMON}"

RUN set -eux && \	
    yum ${YUM_FLAGS_PERSISTENT} install epel-release && \
    yum ${YUM_FLAGS_PERSISTENT} install zeromq python3-pip && \
    yum ${YUM_FLAGS_PERSISTENT} clean all && \
    rm -rf /var/cache/yum/ && \
    pip3 install vpoller supervisor

ENV VPOLLER_WORKER_CONCURRENCY 4

EXPOSE 10123/TCP
EXPOSE 10124/TCP
EXPOSE 9999/TCP
EXPOSE 10000/TCP

VOLUME ["/var/lib/vconnector"]

WORKDIR /var/lib/zabbix
ADD supervisor /etc/supervisor/
ADD run_vpoller_component.sh /
ADD import-hostsfile.sh /
ADD vpoller.conf /etc/vpoller/
ADD vpoller_module.conf /usr/local/etc/zabbix_proxy.conf.d/
ADD vpoller.so builds/vpoller.so 
RUN chmod 0766 /*.sh

ARG YUM_FLAGS_COMMON="-y"
ARG YUM_FLAGS_PERSISTENT="${YUM_FLAGS_COMMON}"

RUN set -eux && \
    yum ${YUM_FLAGS_COMMON} makecache && \
    yum ${YUM_FLAGS_PERSISTENT} install \
            python3-pip && \
    yum ${YUM_FLAGS_PERSISTENT} clean all && \
    pip3 install py-zabbix

ENTRYPOINT ["/run_vpoller_component.sh"]
CMD ["aio"]

