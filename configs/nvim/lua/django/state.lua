---@class DjangoPluginState
---@field cwd string
---@field in_project boolean
local State = {}

State.__index = State

function State:init()
  local state = setmetatable({
    cwd = vim.fn.getcwd(),
    in_project = false,
  }, self)

  return state
end

return State
