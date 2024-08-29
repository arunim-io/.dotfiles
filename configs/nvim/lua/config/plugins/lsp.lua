---@type LazySpec
return {
  {
    "neovim/nvim-lspconfig",
    cmd = "LspInfo",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = "hrsh7th/cmp-nvim-lsp",
    config = function()
      require("config.lsp")
    end,
  },
  {
    "kosayoda/nvim-lightbulb",
    event = "LspAttach",
    opts = {
      autocmd = { enabled = true },
    },
  },
  {
    "b0o/schemastore.nvim",
    ft = { "json", "jsonc", "toml", "yaml", "yml" },
    dependencies = "neovim/nvim-lspconfig",
    event = "LspAttach",
    config = function()
      local lspconfig, schemastore = require("lspconfig"), require("schemastore")

      lspconfig.jsonls.setup({
        init_options = { provideFormatter = false },
        settings = {
          json = {
            schemas = schemastore.json.schemas(),
            validate = { enable = true },
          },
        },
      })
      lspconfig.yamlls.setup({
        settings = {
          yaml = {
            schemaStore = { enable = false, url = "" },
            schemas = schemastore.yaml.schemas(),
          },
        },
      })
    end,
  },
  {
    "zeioth/garbage-day.nvim",
    enabled = false,
    dependencies = "neovim/nvim-lspconfig",
    event = { "VeryLazy", "LspAttach" },
    config = true,
  },
  {
    "folke/trouble.nvim",
    event = "LspAttach",
    cmd = "Trouble",
    config = true,
    keys = {
      {
        "<leader>dd",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Show diagnostics for current buffer",
      },
      {
        "<leader>dw",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Show diagnostics for current workspace",
      },
    },
  },
  { "j-hui/fidget.nvim", event = "LspAttach", config = true },
  {
    "jmbuhr/otter.nvim",
    depndencies = {
      "nvim-treesitter/nvim-treesitter",
      "neovim/nvim-lspconfig",
    },
    config = true,
    init = function()
      vim.api.nvim_create_user_command("OtterActivate", function()
        require("otter").activate()
      end, { desc = "Activate otter" })
    end,
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        "lazydev",
        "lazy.nvim",
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
  { "Bilal2453/luvit-meta", lazy = true },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {
      settings = {
        complete_function_calls = true,
        jsx_close_tags = { enable = true },
      },
    },
  },
  {
    "luckasRanarison/tailwind-tools.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = true,
    init = function()
      vim.api.nvim_create_autocmd("BufWritePre", {
        desc = "Sort tailwind classes before format",
        callback = function()
          ---@diagnostic disable-next-line: missing-parameter
          require("tailwind-tools.lsp").sort_classes()
        end,
      })
    end,
    cond = function()
      local files = vim.fs.find(function(name)
        return name:match("^tailwind%.config%.(js|cjs|ts)$")
      end, { path = vim.fn.getcwd(), type = "file" })

      return #files >= 1
    end,
  },
  {
    "ray-x/go.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    ft = { "go", "gomod" },
    init = function()
      local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.go",
        callback = function()
          require("go.format").goimports()
        end,
        group = format_sync_grp,
      })
    end,
    opts = {
      diagnostic = { update_in_insert = true },
      inlay_hints = { style = "eol" },
      lsp_cfg = true,
      trouble = true,
      luasnip = true,
    },
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    lazy = false,
    config = function(_, opts)
      vim.g.rustaceanvim = opts
    end,
    opts = {
      inlay_hints = { highlight = "NonText" },
      tools = { hover_actions = { auto_focus = true } },
      server = {
        on_attach = function(_, bufnr)
          vim.keymap.set("n", "<leader>ca", function()
            vim.cmd.RustLsp("codeAction")
          end, { silent = true, buffer = bufnr })
        end,
        settings = {
          ["rust-analyzer"] = { check = { command = "clippy" } },
        },
      },
    },
  },
}
