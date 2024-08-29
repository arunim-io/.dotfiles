---@type LazySpec
return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function(_, opts)
    local lint = require("lint")
    lint.linters_by_ft = opts

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      callback = function()
        lint.try_lint()
      end,
    })
  end,
  keys = {
    {
      "<leader>l",
      function()
        require("lint").try_lint()
      end,
      desc = "Lint current buffer",
    },
  },
  opts = {
    bash = { "shellcheck" },
    lua = { "selene" },
    nix = { "statix" },
    sh = { "shellcheck" },
    htmldjango = { "djlint" },
    djangohtml = { "djlint" },
  },
}
