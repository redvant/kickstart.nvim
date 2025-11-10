return {
  {
    'mfussenegger/nvim-dap',
    config = function()
      local dap = require 'dap'
      local custom_dap = require('custom.utils').builder 'custom.dap'
      dap.configurations = custom_dap.configurations
      dap.adapters = custom_dap.adapters

      vim.keymap.set('n', '<F7>', dap.continue, { desc = 'Dap continue' })
      vim.keymap.set('n', '<F8>', dap.step_over, { desc = 'Dap step over' })
      vim.keymap.set('n', '<F9>', dap.step_into, { desc = 'Dap step into' })
      vim.keymap.set('n', '<F10>', dap.step_out, { desc = 'Dap step out' })
      vim.keymap.set('n', '<F12>', dap.restart, { desc = 'Dap restart' })
      vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Dap toggle [B]reakpoint' })
      vim.keymap.set('n', '<leader>dL', function()
        dap.set_breakpoint(nil, nil, vim.fn.input 'Log point message: ')
      end, { desc = '[D]ap set [L]og point' })
      vim.keymap.set('n', '<leader>dr', dap.repl.toggle, { desc = '[D]ap toggle [R]EPL' })
      vim.keymap.set('n', '<leader>dl', dap.run_last, { desc = '[D]ap run [L]ast' })
      vim.keymap.set('n', '<leader>dc', dap.run_to_cursor, { desc = '[D]ap run to [C]ursor' })
      vim.keymap.set('n', '<leader>db', function()
        dap.list_breakpoints(true)
      end, { desc = '[D]ap list [B]reakpoints' })

      vim.keymap.set({ 'n', 'v' }, '<Leader>dh', function()
        require('dap.ui.widgets').hover()
      end, { desc = '[D]ap [H]over value' })
      vim.keymap.set({ 'n', 'v' }, '<Leader>dp', function()
        require('dap.ui.widgets').preview()
      end, { desc = '[D]ap [P]review value' })
      vim.keymap.set('n', '<Leader>df', function()
        local widgets = require 'dap.ui.widgets'
        widgets.centered_float(widgets.frames)
      end, { desc = '[D]ap show [F]rames' })
      vim.keymap.set('n', '<Leader>ds', function()
        local widgets = require 'dap.ui.widgets'
        local columns = vim.o.columns
        local width = math.floor(columns * 0.2)
        widgets.sidebar(widgets.scopes, { width = width }).open()
      end, { desc = '[D]ap show [S]copes' })
    end,
  },
}
