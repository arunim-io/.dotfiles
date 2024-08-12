---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = function()
      require("nvim-treesitter.install").update({ with_sync = true })()
    end,
    opts = {
      auto_install = true,
      snippet_engine = "luasnip",
      highlight = { enable = true },
      incremental_selection = { enable = true },
      indent = { enable = true },
      autotag = { enable = true, enable_close_on_slash = true },
    },
  },
  {
    "windwp/nvim-ts-autotag",
    dependencies = "nvim-treesitter/nvim-treesitter",
    opts = { opts = { enable_close_on_slash = true } },
  },
}
