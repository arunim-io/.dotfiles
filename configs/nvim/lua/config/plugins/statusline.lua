---@type LazySpec
return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons", "folke/trouble.nvim" },
  opts = function(_, opts)
    if opts.sections == nil then
      return opts
    end

    local loaded, trouble = pcall(require, "trouble")

    if not loaded then
      return opts
    end

    local symbols = trouble.statusline({
      mode = "lsp_document_symbols",
      groups = {},
      title = false,
      filter = { range = true },
      format = "{kind_icon}{symbol.name:Normal}",
      hl_group = "lualine_c_normal",
    })

    table.insert(opts.sections.lualine_c, { symbols.get, cond = symbols.has })
  end,
}
