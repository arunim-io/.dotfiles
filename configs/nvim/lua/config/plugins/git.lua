---@type LazySpec[
return {
  { "lewis6991/gitsigns.nvim", event = { "BufReadPre", "BufNewFile" }, config = true },
  {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim", "sindrets/diffview.nvim" },
    config = true,
    keys = {
      { "<leader>gg", "<cmd>Neogit<cr>", desc = "Open Neogit" },
    },
  },
}
