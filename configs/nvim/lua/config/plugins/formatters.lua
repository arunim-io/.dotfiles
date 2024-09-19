---@param bufnr integer
---@param ... string
---@return string
local function first(bufnr, ...)
  local conform = require("conform")
  for i = 1, select("#", ...) do
    local formatter = select(i, ...)
    if conform.get_formatter_info(formatter, bufnr).available then
      return formatter
    end
  end
  return select(1, ...)
end

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
    default_format_opts = {
      lsp_format = "fallback",
    },
    formatters_by_ft = {
      ["_"] = function(bufnr)
        return { first(bufnr, "prettierd", "prettier"), "injected" }
      end,
      lua = { "stylua" },
      nix = { "nixfmt" },
      sh = { "shfmt" },
      fish = { "fish_indent" },
      toml = { "taplo" },
      htmldjango = { "djlint" },
      djangohtml = { "djlint" },
    },
  },
}
