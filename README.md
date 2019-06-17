# docker-go-http-tunnel

Docker image for running [mmatczuk/go-http-tunnel](https://github.com/mmatczuk/go-http-tunnel). This will always build the master repo.

This repository is originally based on [osiloke/go-http-tunnel](https://github.com/osiloke/go-http-tunnel/tree/master/docker),
but provides more flexibility and contains both server and client binaries.

## Install

```
docker pull dcsunset/go-http-tunnel
```

## Usage

### Server Side

A simple example:

```
docker run -d -v ./certs:/data/certs -p 443:443 dcsunset/go-http-tunnel tunneld -tlsCrt /data/certs/server.crt -tlsKey /data/certs/server.key
```

The certificate directories, port and the tunneld command can be easily changed based upon your needs.

To get help on the command parameters, run:

```
docker run --rm dcsunset/go-http-tunnel tunneld -h
```

### Client Side

A simple example:

```
docker run -d -v ./tunnel.yml:/data/tunnel.yml dcsunset/go-http-tunnel tunnel -config /data/tunnel.yml start-all
```

The format of the configuration file is described in [mmatczuk/go-http-tunnel](https://github.com/mmatczuk/go-http-tunnel#configuration).

To get help on the command parameters, run:

```
docker run --rm dcsunset/go-http-tunnel tunnel -h
```

## Build

Clone this repository and run:

```
docker build -t go-http-tunnel .
```

## License

MIT License

