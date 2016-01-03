hackage-downloads
=================
[![Build Status](https://travis-ci.org/haskellbr/hackage-downloads.svg?branch=master)](https://travis-ci.org/haskellbr/hackage-downloads)
[![Docker Pulls](https://img.shields.io/docker/pulls/haskellbr/hackage-downloads.svg)](https://hub.docker.com/r/haskellbr/hackage-downloads/)
- - -
A little script that pulls Hackage download counts and exposes them as JSON.

## Command-line
```bash
$ hackage-downloads
# ...
{"name":"goal-simulation","href":"/package/goal-simulation","downloads":2}
{"name":"http-client-request-modifiers","href":"/package/http-client-request-modifiers","downloads":2}
{"name":"selenium-server","href":"/package/selenium-server","downloads":2}
```

## HTTP API
```bash
$ hackage-downloads-api &
Spock is running on port 3000
Scrapping Hackage...
$ curl -L -s localhost:3000
[
  # ...
  {"name":"goal-simulation","href":"/package/goal-simulation","downloads":2},
  {"name":"http-client-request-modifiers","href":"/package/http-client-request-modifiers","downloads":2},
  {"name":"selenium-server","href":"/package/selenium-server","downloads":2}
]
```

## Binary Distribution
You can download binary distributions for both these executables for Linux
64-bits from S3 which are built and uploaded by the CI system from these links:

- [`hackage-downloads`](http://haskellbr.com.s3-website-sa-east-1.amazonaws.com/hackage-downloads/hackage-downloads.bz2 > hackage-downloads.bz2)
- [`hackage-downloads-api`](http://haskellbr.com.s3-website-sa-east-1.amazonaws.com/hackage-downloads/hackage-downloads-api.bz2 > hackage-downloads-api.bz2)

## Docker Distribution
The repository has a `Makefile` which offers a simple way of creating and
publishing a Docker image for both executables (though mostly meant to run the
web service), which should be available [here](https://hub.docker.com/r/haskellbr/hackage-downloads/).

```bash
$ docker run -d -it -p 3000:3000 haskellbr/hackage-downloads
$ curl `docker-machine ip default`:3000
# ...
```

## License
This code is licensed under the MIT license. For more information please refer
to the [LICENSE](/LICENSE) file.
