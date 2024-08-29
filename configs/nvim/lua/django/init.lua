local Config = require("django.config")
local State = require("django.state")

---@class DjangoPlugin
---@field config DjangoPluginConfig
---@field state DjangoPluginState
local Plugin = {}

Plugin.__index = Plugin

---@return DjangoPlugin
function Plugin:new()
  local plugin = setmetatable({
    state = State:init(),
    config = Config:default(),
  }, self)

  plugin:init()

  return plugin
end

---@private
function Plugin:init()
  self:detect()

  if self.config.create_autocmd then
    require("django.autocmd").create_autocmd(self.config.create_autocmd)
  end
end

---@private
function Plugin:detect()
  local manage_py_found = vim.fn.filereadable(self.state.cwd .. "/manage.py") == 1
  local env_found = vim.env.DJANGO_SETTINGS_MODULE ~= nil

  if manage_py_found or env_found then
    self.in_project = true
  end
end

---@param config DjangoPluginConfig?
---@return DjangoPlugin
function Plugin.setup(config)
  local django = Plugin:new()

  if config ~= nil then
    table.insert(django, config)
  end

  return django
end

return Plugin
