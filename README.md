# protonvpn docker with tinyproxy

## Usage

```
$ docker run --rm \
           --device /dev/net/tun \
           --cap-add NET_ADMIN \
           -v $(pwd)/vpnlogin.conf:/login.conf \
           -p 9999:8888 \
           x
```

```
$ curl -x localhost:9999 https://ipinfo.io/
```

## Test / Validation

Using ipinfo.io

```
docker run --rm \
           --device /dev/net/tun \
           --cap-add NET_ADMIN \
           -v $(pwd)/vpnlogin.conf:/login.conf \
           -p 9999:8888 \
           x
```

```
$ curl -x localhost:9999 https://ipinfo.io/ip
149.34.244.143
```
