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
}
