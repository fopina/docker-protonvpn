FROM python:3.10-alpine

RUN apk add --no-cache openvpn tinyproxy bash s6 envsubst

RUN --mount=type=cache,target=/root/.cache/pip \
    pip install protonvpn-cli==2.2.11

ENV VPNCC="US"
ENV PYTHONUNBUFFERED=1
# as per https://tinyproxy.github.io/: Critical, Error, Warning, Notice, Connect, Info
ENV TINYPROXY_LOG_LEVEL="Info"
ENV TINYPROXY_MAX_CLIENTS=100

COPY s6 /etc/s6
COPY tinyproxy.conf.tmpl /etc/tinyproxy/tinyproxy.conf.tmpl
COPY pvpn-cli.cfg.tmpl /

ENTRYPOINT [ "/bin/s6-svscan", "/etc/s6" ]
CMD []
