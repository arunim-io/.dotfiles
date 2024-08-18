---@type LazySpec
return {
  "stevearc/conform.nvim",
  cmd = "ConformInfo",
  event = "BufReadPre",
  init = function()
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
  keys = {
    {
      "<leader>f",
      function()
        require("conform").format({ async = true })
      end,
      desc = "Format buffer in view",
    },
  },
  ---@type conform.setupOpts
  opts = {
    format_on_save = {
      timeout_ms = 500,
    },
    default_format_opts = {
      timeout_ms = 500,
      lsp_format = "fallback",
    },
    formatters_by_ft = {
      ["_"] = { "prettierd" },
      css = { "prettierd" },
      lua = { "stylua" },
      nix = { "nixfmt" },
      sh = { "shfmt" },
      fish = { "fish_indent" },
      toml = { "taplo" },
    },
  },
}
