local api = require("zellij.api")
local cmd = require("zellij.cmd")

if api.is_running then
  cmd.create_nvim_cmd()

  local directions = { "left", "right", "up", "down" }

  for _, direction in ipairs(directions) do
    vim.keymap.set(
      "n",
      string.format("<A-%s>", direction),
      string.format("<cmd>Zellij navigate %s<cr>", direction),
      { desc = string.format("Navigate %s", direction) }
    )
  end

  vim.api.nvim_create_autocmd({ "VimEnter", "WinEnter" }, {
    callback = function()
      api.switch_mode("locked")
    end,
  })

  vim.api.nvim_create_autocmd({ "VimLeave" }, {
    callback = function()
      api.switch_mode("normal")
    end,
  })
end
