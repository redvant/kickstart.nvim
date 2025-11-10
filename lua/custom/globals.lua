function _G.P_BUF(thing)
  local inspected_string = vim.inspect(thing)
  local lines = vim.split(inspected_string, '\n')

  -- Create a new buffer in a new split
  vim.cmd 'new'

  -- Set filetype to Lua for syntax highlighting
  vim.bo.filetype = 'lua'

  -- Insert the lines into the new buffer
  vim.api.nvim_buf_set_lines(0, 0, -1, true, lines)
end

-- Usage:
-- :lua P_BUF(vim.lsp.get_active_clients())
