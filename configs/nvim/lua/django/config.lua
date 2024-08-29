---@class DjangoPluginConfig
local Config = {}

Config.__index = Config

---@return DjangoPluginConfig
function Config:default()
  return {}
end

return Config
