---@class DjangoPluginConfig

---@class DjangoPlugin
---@field private augroup integer
---@field private cwd string
---@field in_project boolean Whether Django is present.
---@field config DjangoPluginConfig
local DjangoPlugin = {}

DjangoPlugin.__index = DjangoPlugin

--- Create an instance of [DjangoPlugin](lua://DjangoPlugin)
---@return DjangoPlugin
function DjangoPlugin:new()
  local plugin = setmetatable({
    cwd = vim.fn.getcwd(),
    augroup = vim.api.nvim_create_augroup("Django", { clear = false }),
  }, self)

  plugin:init()

  return plugin
end

---@private
function DjangoPlugin:init()
  self:detect()

  vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    group = self.augroup,
    buffer = vim.api.nvim_get_current_buf(),
    command = [[set filetype=htmldjango]],
  })
end

---@private
function DjangoPlugin:detect()
  local manage_py_found = vim.fn.filereadable(self.cwd .. "/manage.py") == 1
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
