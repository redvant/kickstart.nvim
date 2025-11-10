return {
  'tpope/vim-dispatch',
  'HiPhish/rainbow-delimiters.nvim',
  {
    'numToStr/Comment.nvim',
    opts = {},
  },
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
}
