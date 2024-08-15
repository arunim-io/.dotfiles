---@type LazySpec
return {
  { "nvim-lua/plenary.nvim", lazy = true },
  { "stevearc/dressing.nvim", config = true },
  {
    "echasnovski/mini.icons",
    config = true,
    specs = {
      { "nvim-tree/nvim-web-devicons", enabled = false, optional = true },
    },
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },
  {
    "coffebar/neovim-project",
    lazy = false,
    priority = 100,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "Shatur/neovim-session-manager",
    },
    init = function()
      vim.opt.sessionoptions:append("globals")
    end,
    opts = {
      projects = { "~/Projects/*", "~/.config/*", "~/.dotfiles/" },
      last_session_on_startup = false,
    },
  },
  {
    "stevearc/oil.nvim",
    enabled = false,
    dependencies = "echasnovski/mini.icons",
    keys = {
      { "<leader>pv", "<cmd>Oil<cr>", desc = "Show file explorer" },
    },
    opts = {
      skip_confirm_for_simple_edits = true,
      lsp_file_methods = { autosave_changes = true },
      watch_for_changes = true,
      view_options = { show_hidden = true },
    },
  },
  {
    "echasnovski/mini.files",
    version = false,
    lazy = false,
    init = function()
      vim.g.loaded_netrwPlugin = 1
      vim.g.loaded_netrw = 1
    end,
    keys = {
      {
        "<leader>pv",
        function()
          require("mini.files").open()
        end,
        desc = "Open file manager",
      },
    },
    opts = {
      mappings = {
        synchronize = "s",
        go_in = "<Right>",
        go_out = "<Left>",
        go_in_plus = "",
        go_out_plus = "",
      },
    },
  },
  {
    "OXY2DEV/helpview.nvim",
    lazy = false,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  },
}
