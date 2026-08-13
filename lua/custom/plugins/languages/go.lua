return {
  {
    'fredrikaverpil/godoc.nvim',
    version = '*',
    dependencies = {
      { 'nvim-telescope/telescope.nvim' }, -- optional
      { 'nvim-treesitter/nvim-treesitter', opts = { ensure_installed = { 'go' } } },
    },
    build = 'go install github.com/lotusirous/gostdsym/stdsym@latest',
    cmd = { 'GoDoc' },
    opts = {
      picker = {
        type = 'telescope',
      },
    },
    keys = {
      {
        '<leader>gd',
        vim.cmd.GoDoc,
        desc = 'Go search docs (Telescope)',
      },
    },
  },
  {
    'leoluz/nvim-dap-go',
    config = function()
      local dapgo = require 'dap-go'
      dapgo.setup()
      vim.keymap.set('n', '<leader>dgt', dapgo.debug_test, { desc = 'Dap-go run test' })
      vim.keymap.set('n', '<leader>dgl', dapgo.debug_last_test, { desc = 'Dap-go run last test' })
    end,
  },
}
