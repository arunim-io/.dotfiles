---@type LazySpec
return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  config = true,
  init = function()
    local telescope = require("telescope")

    telescope.load_extension("fzf")
  end,
  keys = {
    { "<leader>pfr", "<cmd>Telescope find_files<cr>", desc = "Find files in the root directory" },
    { "<leader>pfg", "<cmd>Telescope git_files<cr>", desc = "Find files tracked by git" },
    {
      "<leader>pfa",
      function()
        require("telescope.builtin").find_files({
          prompt_title = "Find adjacent files",
          cwd = vim.fn.expand("%:p:h"),
        })
      end,
      desc = "Find files adjacent to the currently opened file",
    },
    {
      "<leader>ps",
      function()
        require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ") })
      end,
      desc = "Search using grep",
    },
  },
}
