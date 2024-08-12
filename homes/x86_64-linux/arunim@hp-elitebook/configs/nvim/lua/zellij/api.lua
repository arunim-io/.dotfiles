local focus_direction_map = {
  left = "h",
  down = "j",
  up = "k",
  right = "l",
}

--- Move focus to another neovim buffer or zellij pane
---@param direction 'left'|'right'|'up'|'down'
local function move_focus(direction)
  local cur_winnr = vim.fn.winnr()
  vim.api.nvim_command("wincmd " .. focus_direction_map[direction])

  local new_winnr = vim.fn.winnr()

  if cur_winnr == new_winnr then
    vim.fn.system("zellij action move-focus " .. direction)
    if vim.v.shell_error ~= 0 then
      vim.notify("zellij.nvim: `zellij` executable not found in PATH", vim.log.levels.ERROR)
    end
  end
end

return { move_focus = move_focus }
