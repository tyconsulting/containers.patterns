# Shadowsocks Container

## Test Locally

### Build

```json
docker build -t shadowsocks:0.1 .
```

### Run

```json
docker run --name shadowsock -dp 8388:8388 --rm shadowsocks:0.1
```