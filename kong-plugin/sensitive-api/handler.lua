-- Using lua-radix-router to build a router for request path matching,
-- and perform extra validation for the sensitive API.
-- Copyright (c) 2024, Yusheng Li

local kong_meta = require "kong.meta"
local Router = require "radix-router"

local kong = kong

local SensitiveApiHandler = {}

SensitiveApiHandler.PRIORITY = 0
SensitiveApiHandler.VERSION = kong_meta.version

local cache = setmetatable({}, {
  __mode = "k",
  __index = function(self, conf)
    local routes = {}
    for api, value in pairs(conf.apis) do
      local route = {
        paths = { api },
        methods = value.methods,
        handler = true,
      }
      table.insert(routes, route)
    end
    local router, err = Router.new(routes)
    if not router then
      error("faild to new router: ", err)
    end
    kong.log.warn("router created")
    self[conf] = router
    return router
  end
})

function SensitiveApiHandler:access(conf)
  local router = cache[conf]
  local path = kong.request.get_path()
  local method = kong.request.get_method()

  local matched = {}
  local handler = router:match(path, { method = method }, nil, matched)
  if handler then
    kong.service.request.add_header("x-debug-matched-path", matched.path)
    kong.service.request.add_header("x-debug-matched-method", matched.method)
    -- TODO validating the request
  end
end

return SensitiveApiHandler
