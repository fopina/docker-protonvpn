FROM python:3.10-alpine

RUN apk add --no-cache openvpn tinyproxy bash s6 envsubst iptables

RUN --mount=type=cache,target=/root/.cache/pip \
    pip install https://github.com/Rafficer/linux-cli-community/archive/refs/tags/v2.2.12.tar.gz

# RUN --mount=type=cache,target=/root/.cache/pip \
#     pip install protonvpn-cli==2.2.12

ENV VPNCC="US"
ENV PYTHONUNBUFFERED=1
# as per https://tinyproxy.github.io/: Critical, Error, Warning, Notice, Connect, Info
ENV TINYPROXY_LOG_LEVEL="Info"
ENV TINYPROXY_MAX_CLIENTS=100
ENV TINYPROXY_TIMEOUT=600

COPY s6 /etc/s6
COPY tinyproxy.conf.tmpl /etc/tinyproxy/tinyproxy.conf.tmpl
COPY pvpn-cli.cfg.tmpl /

ENTRYPOINT [ "/bin/s6-svscan", "/etc/s6" ]
CMD []
