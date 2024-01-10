-- Copyright (c) 2024, Yusheng Li

local typedefs = require "kong.db.schema.typedefs"

return {
  name = "sensitive-api",
  fields = {
    { protocols = typedefs.protocols_http },
    { config = {
      type = "record",
      fields = {
        { apis = {
          type = "map",
          keys = { type = "string" },
          values = { type = "record", fields = {
            { methods = { type = "array", elements = {
              type = "string",
              one_of = { "GET", "POST", "PUT", "PATCH", "DELETE" },
            }, }, },
          } },
        }, },
      },
    },
    },
  },
}
