# Lua-Radix-Router use cases

> Lua-Radix-Router is a lightweight high-performance router library written in pure Lua.

The use cases of [lua-radix-router](https://github.com/vm-001/lua-radix-router).


## Kong Gateway Plugins

- [sensitive-api](kong-plugin/README.md): A plugin uses lua-radix-router to build a router for request path matching, and perform extra validation for sensitive APIs. The plugin add `X-Debug-Matched-Method` and `X-Debug-Matched-Path` headers to upstream when client is requesting the sensitive API. 



## Enhances the Kong Gateway Router 

Kong currently has three routers, `traditional_compatible`, `expressions`, and `traditional`. You can add a new router implementation by using the lua-radix-router. See [commit](https://github.com/vm-001/lua-radix-router-use-cases/commit/dadc8d36e6329d2efdb8985ab9075221159e9105).

The lua-radix-router is ideal for when you have a lot of routes that don't rely on regular expressions. See the [Benchmarks](https://github.com/vm-001/lua-radix-router?tab=readme-ov-file#-benchmarks).


## Game

- [skynet_fly](https://github.com/huahua132/skynet_fly): An out-of-the-box microservice framework based on [Skynet](https://github.com/cloudwu/skynet) with graceful hot update.

## Contribution

If you would like to share your awesome projects using lua-dix-router here, feel free to create a pull request.