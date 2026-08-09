return {
  'tpope/vim-dispatch',
  {
    'tpope/vim-fugitive',
    keys = {
      { '<leader>gs', '<cmd>Git<CR>', desc = '[G]it [S]tatus' },
      { '<leader>gb', '<cmd>Git blame<CR>', desc = '[G]it [B]lame' },
    },
  },
  {
    'tpope/vim-rhubarb',
    dependencies = { 'tpope/vim-fugitive' },
    keys = {
      { '<leader>gw', '<cmd>GBrowse<CR>', desc = '[G]it Bro[w]se' },
      { '<leader>gW', '<cmd>.GBrowse<CR>', desc = '[G]it Bro[w]se to current line' },
    },
  },
  'HiPhish/rainbow-delimiters.nvim',
  {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = 'markdown',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    opts = {
      bullet = { icons = { '', '', '◆', '◇' } },
    },
    keys = {
      {
        '<leader>mr',
        function()
          require('render-markdown').toggle()
        end,
        ft = 'markdown',
        desc = 'Toggle renderMarkdown',
      },
    },
  },
  {
    'NMAC427/guess-indent.nvim',
    config = function()
      require('guess-indent').setup {}
    end,
  },
  {
    'christoomey/vim-tmux-navigator',
    cmd = {
      'TmuxNavigateLeft',
      'TmuxNavigateDown',
      'TmuxNavigateUp',
      'TmuxNavigateRight',
      'TmuxNavigatePrevious',
      'TmuxNavigatorProcessList',
    },
    keys = {
      { '<c-h>', '<cmd><C-U>TmuxNavigateLeft<cr>' },
      { '<c-j>', '<cmd><C-U>TmuxNavigateDown<cr>' },
      { '<c-k>', '<cmd><C-U>TmuxNavigateUp<cr>' },
      { '<c-l>', '<cmd><C-U>TmuxNavigateRight<cr>' },
      { '<c-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>' },
    },
  },
}
