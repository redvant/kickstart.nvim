-- tabs set to 4 width, not convert into spaces
vim.bo.tabstop = 4
vim.bo.softtabstop = 4
vim.bo.shiftwidth = 4
vim.bo.expandtab = false

-- Go shortcuts
vim.keymap.set('n', '<leader>gt', function()
  vim.cmd '!go test'
end, { buffer = 0, desc = 'Go run tests' })
