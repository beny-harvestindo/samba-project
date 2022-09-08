FROM debian:bullseye-slim

COPY config /.docker/config
COPY bash /.docker/
COPY entrypoint.sh /entrypoint.sh
RUN chmod -R 755 /.docker

RUN apt update \
    && apt upgrade -y \
    && apt install -y samba smbclient krb5-kdc winbind vim iproute2 telnet
    
ENV DNS_FORWARD_1 1.1.1.1 \
    DNS_FORWARD_2 4.4.4.4 \
    DNS_DOMAIN sambaad.top \
    AD_PASSWORD password88 \
    AD_REALM sambaad.top \
    AD_HOST ad \
    AD_DOMAIN SAMBAAD \
    AD_NOSTRONGAUTH 1 \
    AD_HOST_IP "" \
    AD_OPTIONS "" \
    AD_AGE_PASSWORD 1

VOLUME ["/var/lib/samba", "/var/log/samba", "/etc/samba", "/run/samba"]

EXPOSE 53 53/udp 135 137/udp 138/udp 139 389 445 464 636

ENTRYPOINT ["/entrypoint.sh"]

RUN apt autoremove -y && apt clean && rm -rf /var/lib/apt/lists/*
