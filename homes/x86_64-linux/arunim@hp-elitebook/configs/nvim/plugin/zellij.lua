local cmd = require("zellij.cmd")

local zellij_running = vim.env.ZELLIJ

if zellij_running then
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
end
