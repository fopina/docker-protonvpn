default: build

all: test pub

build:
	docker build -t x .

test:
	echo "tests done (NOT)"

pub:
	docker buildx build \
	              --platform linux/amd64,linux/arm64 \
				  --build-arg VERSION=$(shell git log --oneline . | wc -l | tr -d ' ') \
				  -t fopina/protonvpn:$(shell git log --oneline . | wc -l | tr -d ' ') \
				  -t ghcr.io/fopina/protonvpn:$(shell git log --oneline . | wc -l | tr -d ' ') \
				  --push .

demo: build
	docker run --rm \
           --device /dev/net/tun \
           --cap-add NET_ADMIN \
           -v $(PWD)/vpnlogin.conf:/login.conf \
           -p 9999:8888 \
           x
