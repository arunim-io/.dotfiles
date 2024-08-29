local Config = require("django.config")
local State = require("django.state")

---@class DjangoPlugin
---@field config DjangoPluginConfig
---@field state DjangoPluginState
local DjangoPlugin = {}

DjangoPlugin.__index = DjangoPlugin

--- Create an instance of [DjangoPlugin](lua://DjangoPlugin)
---@return DjangoPlugin
function DjangoPlugin:new()
  local plugin = setmetatable({
    state = State:init(),
    config = Config:default(),
  }, self)

  plugin:init()

  return plugin
end

---@private
function DjangoPlugin:init()
  self:detect()

  vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    group = vim.api.nvim_create_augroup("Django", { clear = false }),
    buffer = vim.api.nvim_get_current_buf(),
    command = [[set filetype=htmldjango]],
  })
end

---@private
function DjangoPlugin:detect()
  local manage_py_found = vim.fn.filereadable(self.state.cwd .. "/manage.py") == 1
  local env_found = vim.env.DJANGO_SETTINGS_MODULE ~= nil

  if manage_py_found or env_found then
    self.in_project = true
  end
end

---@param config DjangoPluginConfig?
---@return DjangoPlugin
function DjangoPlugin.setup(config)
  local django = DjangoPlugin:new()

  if config ~= nil then
    table.insert(django, config)
  end

  return django
end

return DjangoPlugin
