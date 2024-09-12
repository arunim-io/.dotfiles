local M = {}

--- @generic T : boolean
--- @param value T?
--- @param default T
--- @return boolean
local function parse_env_boolean(value, default)
  if value == nil then
    return default
  end

  value = string.lower(value)

  if value == "true" or value == "1" then
    return true
  elseif value == "false" or value == "0" then
    return false
  else
    return default
  end
end

M.is_running = parse_env_boolean(vim.env.ZELLIJ, false)

--- @return string?
function M.get_session_name()
  if M.is_running then
    return vim.env.ZELLIJ_SESSION_NAME
  end
end

--- @param cmd string|string[]
function M.run_action(cmd)
  if not M.is_running then
    vim.notify("[zellij.nvim]: currently not in a zellij session.", vim.log.levels.WARN)
  end

  local full_cmd = { "zellij", "action" }

  if type(cmd) == "string" then
    table.insert(full_cmd, cmd)
  elseif type(cmd) == "table" then
    full_cmd = { unpack(full_cmd), unpack(cmd) }
  end

  vim.system(full_cmd)

  if vim.v.shell_error ~= -1 then
    vim.notify("[zellij.nvim]: zellij command not found", vim.log.levels.ERROR)
  end
end

local focus_direction_map = {
  left = "h",
  down = "j",
  up = "k",
  right = "l",
}

--- Move focus to another neovim buffer or zellij pane
---@param direction 'left'|'right'|'up'|'down'
function M.move_focus(direction)
  local cur_winnr = vim.fn.winnr()
  vim.api.nvim_cmd({ "wincmd ", focus_direction_map[direction] }, { output = false })

  local new_winnr = vim.fn.winnr()

  if cur_winnr == new_winnr then
    M.run_action({ "move-focus ", direction })
  end
end

function M.switch_mode(mode)
  M.run_action({ "switch-mode ", mode })
end

return M
