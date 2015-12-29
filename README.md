hackage-downloads
=================
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

## License
This code is licensed under the MIT license. For more information please refer
to the [LICENSE](/LICENSE) file.
