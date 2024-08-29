local M = {}

M.augroup = vim.api.nvim_create_augroup("Django", { clear = false })

--- @param create boolean
function M.create_autocmd(create)
  if not create then
    return
  end

  vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    group = M.augroup,
    buffer = vim.api.nvim_get_current_buf(),
    command = [[set filetype=htmldjango]],
  })
end

return M
