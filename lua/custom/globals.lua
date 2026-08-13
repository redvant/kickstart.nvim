---Opens the result of thing in a new buffer
---Usage:
---:lua P_BUF(vim.lsp.get_active_clients())
function _G.P_BUF(thing)
  local inspected_string = vim.inspect(thing)
  local lines = vim.split(inspected_string, '\n')

  -- Create a new scratch buffer in a new split
  local scratch_buf = vim.api.nvim_create_buf(true, true)
  vim.api.nvim_open_win(scratch_buf, true, { split = 'below' })

  -- Set filetype to Lua for syntax highlighting
  vim.bo.filetype = 'lua'

  -- Insert the lines into the new buffer
  vim.api.nvim_buf_set_lines(0, 0, -1, true, lines)
end

local languages = {}
-- List the languages that you want to enable
-- languages = { 'lua', 'go', 'clojure', 'dart', 'markdown' }
_G.LANGUAGES_ENABLED = require('custom.utils').new_Set(languages)
