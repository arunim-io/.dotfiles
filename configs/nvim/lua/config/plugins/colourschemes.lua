--- @type LazySpec
return {
  {
    "navarasu/onedark.nvim",
    lazy = false,
    priority = 1000,
    init = function()
      vim.cmd.colorscheme("onedark")
    end,
    opts = {
      style = "warmer",
      lualine = { transparent = true },
    },
  },
}
