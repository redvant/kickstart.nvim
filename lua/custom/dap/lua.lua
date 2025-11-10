local local_lua = vim.fs.joinpath(vim.fn.stdpath 'data', 'mason', 'packages', 'local-lua-debugger-vscode', 'extension')
local local_lua_adapter = vim.fs.joinpath(local_lua, 'extension', 'debugAdapter.js')

return {
  configurations = {
    lua = {
      {
        name = 'Current file (local-lua-dbg, lua)',
        type = 'local-lua',
        request = 'launch',
        cwd = '${workspaceFolder}',
        program = {
          lua = 'lua',
          file = '${file}',
        },
        args = {},
      },
    },
  },
  adapters = {
    ['local-lua'] = {
      type = 'executable',
      command = 'node',
      args = {
        local_lua_adapter,
      },
      enrich_config = function(config, on_config)
        if not config['extensionPath'] then
          local c = vim.deepcopy(config)
          c.extensionPath = local_lua
          on_config(c)
        else
          on_config(config)
        end
      end,
    },
  },
}
