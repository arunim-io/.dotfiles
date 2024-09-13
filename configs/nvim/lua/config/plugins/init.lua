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
    "aserowy/tmux.nvim",
    opts = {
      navigation = { enable_default_keybindings = false },
      resize = { enable_default_keybindings = false },
    },
    keys = {
      {
        "<C-Up>",
        function()
          require("tmux").move_top()
        end,
      },
      {
        "<C-Down>",
        function()
          require("tmux").move_bottom()
        end,
      },
      {
        "<C-Left>",
        function()
          require("tmux").move_left()
        end,
      },
      {
        "<C-Right>",
        function()
          require("tmux").move_right()
        end,
      },
      {
        "<M-Up>",
        function()
          require("tmux").resize_top()
        end,
      },
      {
        "<M-Down>",
        function()
          require("tmux").resize_bottom()
        end,
      },
      {
        "<M-Left>",
        function()
          require("tmux").resize_left()
        end,
      },
      {
        "<M-Right>",
        function()
          require("tmux").resize_right()
        end,
      },
    },
  },
}
