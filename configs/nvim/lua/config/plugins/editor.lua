local highlight = {
  "RainbowRed",
  "RainbowYellow",
  "RainbowBlue",
  "RainbowOrange",
  "RainbowGreen",
  "RainbowViolet",
  "RainbowCyan",
}

---@type LazySpec
return {
  {
    "HiPhish/rainbow-delimiters.nvim",
    config = function(_, opts)
      vim.g.rainbow_delimiters = opts
    end,
    opts = { highlight = highlight },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "BufRead",
    config = function(_, opts)
      local hooks = require("ibl.hooks")

      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
      end)
      hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)

      require("ibl").setup(opts)
    end,
    opts = {
      scope = { highlight = highlight },
      indent = { char = "▏" },
    },
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    dependencies = "hrsh7th/nvim-cmp",
    init = function()
      require("cmp").event:on("conform_done", require("nvim-autopairs.completion.cmp").on_confirm_done())
    end,
    opts = {
      check_ts = true,
      disable_in_visualblock = true,
      fast_wrap = { map = "<C-e>" },
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    config = true,
  },
  { "chrisgrieser/nvim-puppeteer", lazy = false },
  { "gregorias/coerce.nvim", config = true, enabled = false },
  {
    "echasnovski/mini.trailspace",
    version = false,
    config = true,
    init = function()
      vim.api.nvim_create_autocmd("BufWrite", {
        callback = function()
          local plugin = require("mini.trailspace")

          plugin.trim()
          plugin.trim_last_lines()
        end,
      })
    end,
  },
  {
    "echasnovski/mini.splitjoin",
    version = false,
    config = true,
    keys = {
      {
        "<leader>gst",
        function()
          require("mini.splitjoin").toggle()
        end,
        desc = "split if arguments are on single line, join otherwise.",
      },
      {
        "<leader>gss",
        function()
          require("mini.splitjoin").split()
        end,
        desc = "make every argument separator be on end of separate line.",
      },
      {
        "<leader>gsj",
        function()
          require("mini.splitjoin").join()
        end,
        desc = "make all arguments be on single line.",
      },
    },
  },
  {
    "jiaoshijie/undotree",
    dependencies = "nvim-lua/plenary.nvim",
    opts = {
      position = "right",
    },
    keys = {
      {
        "<leader>u",
        function()
          require("undotree").toggle()
        end,
        desc = "open undotree",
      },
    },
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = "nvim-lua/plenary.nvim",
    config = true,
    keys = {
      {
        "<leader>hl",
        function()
          local harpoon = require("harpoon")
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = "harpooon list",
      },
      {
        "<leader>ha",
        function()
          require("harpoon"):list():add()
        end,
        desc = "harpooon add to list",
      },
      {
        "<C-p>",
        function()
          require("harpoon"):list():prev()
        end,
        desc = "harpooon previous item",
      },
      {
        "<C-n>",
        function()
          require("harpoon"):list():next()
        end,
        desc = "harpooon next item",
      },
    },
  },
}
