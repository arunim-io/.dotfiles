--- @type LazySpec
return {
  "EdenEast/nightfox.nvim",
  lazy = false,
  priority = 1000,
  init = function()
    vim.cmd.colorscheme("nightfox")
  end,
}
