---@class DjangoPlugin
---@field private augroup integer
---@field cwd string path to current directory.
---@field in_project? boolean Whether Django is present.
---@field templates string[]? List of Django templates
local Plugin = {
  cwd = vim.fn.getcwd(),
  augroup = vim.api.nvim_create_augroup("Django", { clear = false }),
}

Plugin.__index = Plugin

function Plugin:init()
  self:detect()

  vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    group = self.augroup,
    buffer = vim.api.nvim_get_current_buf(),
    command = [[set filetype=htmldjango]],
  })
end

---@private
function Plugin:detect()
  local manage_py_found = vim.fn.filereadable(self.cwd .. "/manage.py") == 1
  local env_found = vim.env.DJANGO_SETTINGS_MODULE ~= nil

  if manage_py_found or env_found then
    self.in_project = true
  end
end

do
  Plugin:init()
  print("Django project detected:", Plugin.in_project)
end
