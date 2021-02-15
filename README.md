# docker-go-http-tunnel

Docker image for running [mmatczuk/go-http-tunnel](https://github.com/mmatczuk/go-http-tunnel). This will always build the master repo.

This repository is originally based on [osiloke/go-http-tunnel](https://github.com/osiloke/go-http-tunnel/tree/master/docker), and [grugnog/go-http-tunnel](https://github.com/grugnog/go-http-tunnel/tree/master/docker) but provides more flexibility and contains both server and client binaries.

## Install

```
docker pull panta/go-http-tunnel
```

## Usage

### Docker run env options

This image can be run using a couple of environment variables that configures the image.

#### TunnelD config


| VARIABLE | DESCRIPTION | DEFAULT |
| :------- | :---------- | :------ |
| DEBUG | turn on debugging | false |
| CLIENTS | Specify comma separated client ID's that should recognize | empty |
| DISABLE_HTTPS | Disables https | false | 

#### Tunnel config


| VARIABLE | DESCRIPTION | DEFAULT |
| :------- | :---------- | :------ |
| TUNNEL_CONFIG | config file | /tunnel.yml |

#### TLS Cert

| VARIABLE | DESCRIPTION | DEFAULT |
| :------- | :---------- | :------ |
| COUNTY | Certificate subject country string | US |
| STATE | Certificate subject state string | New Jersey |
| LOCATION | Certificate subject location string | Piscataway |
| ORGANISATION | Certificate subject organisation string | Example |
| ROOT_CN | Root certificate common name | Root |
| ISSUER_CN | Intermediate issuer certificate common name | Example Ltd |
| PUBLIC_CN | Public certificate common name | *.example.com |
| ROOT_NAME | Root certificate filename | root |
| ISSUER_NAME | Intermediate issuer certificate filename | example |
| PUBLIC_NAME | Public certificate filename | public |
| RSA_KEY_NUMBITS | The size of the rsa keys to generate in bits | 2048 |
| DAYS | The number of days to certify the certificates for | 365 |

### Server Side

```bash
$ docker run -v /etc/ssl/certs:/etc/ssl/certs -p 4443:4443 panta/go-http-tunnel tunneld
```

The certificate directories, port and the tunneld command can be easily changed based upon your needs.

To get help on the command parameters, run:

```bash
$ docker run --rm panta/go-http-tunnel /usr/bin/tunneld -h
```

### Client Side

A simple example:

```bash
$ docker run -d -v ./tunnel.yml:/tunnel.yml panta/go-http-tunnel tunnel
```

The format of the configuration file is described in [mmatczuk/go-http-tunnel](https://github.com/mmatczuk/go-http-tunnel#configuration).

To get help on the command parameters, run:

```bash
$ docker run --rm panta/go-http-tunnel /usr/bin/tunnel -h
```

## Build

Clone this repository and run:

```
docker build -t go-http-tunnel .
```

## License

MIT License

