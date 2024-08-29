---@class DjangoPluginConfig
---@field create_autocmd boolean
local Config = {}

Config.__index = Config

---@return DjangoPluginConfig
function Config:default()
  return {
    create_autocmd = true,
  }
end

return Config
