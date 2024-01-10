# Kong Plugin

The sensitive-api plugin uses lua-radix-router to build a router for request path matching, and perform extra validation for the sensitive API. The plugin add `X-Debug-Matched-Method` and `X-Debug-Matched-Path` headers to upstream when client is requesting the sensitive API. 

```yaml
# kong.yaml
_format_version: "3.0"

services:
  - name: example-service
    host: httpbin.org
    port: 80
    path: /anything
    protocol: http
    routes:
      - name: example-route
        paths:
          - /
    plugins:
      - name: sensitive-api
        config:
          apis:
            "/api/login": { methods: [ "POST" ] }
            "/api/users/{id}/update_email": { methods: [ "POST" ] }
            "/api/users/{id}/settings/{*path}": { methods: [ "POST", "PUT" ] }

```

```
$ curl -X PUT http://localhost:8000/api/users/109/settings/email/update
```

```json
{
    "args": {},
    "data": "",
    "files": {},
    "form": {},
    "headers": {
        "Accept": "*/*",
        "Host": "httpbin.org",
        "User-Agent": "curl/8.4.0",
        "X-Amzn-Trace-Id": "Root=1-659ebcbe-6b9f817b4df04177178ade7a",
        "X-Debug-Matched-Method": "PUT",
        "X-Debug-Matched-Path": "/api/users/{id}/settings/{*path}",
        "X-Forwarded-Host": "localhost",
        "X-Forwarded-Path": "/api/users/109/settings/email/update",
        "X-Kong-Request-Id": "d3388a479acf8122bfb3ef373415125c"
    },
    "json": null,
    "method": "PUT",
    "url": "http://localhost/anything/api/users/109/settings/email/update"
}

```