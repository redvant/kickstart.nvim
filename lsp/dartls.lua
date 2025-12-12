local dartExcludedFolders = {
  vim.fn.expand '$HOME/.pub-cache',
  vim.fn.expand '$HOME/tools/flutter/',
}

---@type vim.lsp.Config
return {
  cmd = {
    'dart',
    'language-server',
    '--protocol=lsp',
    -- "--port=8123",
    -- "--instrumentation-log-file=/Users/robertbrunhage/Desktop/lsp-log.txt",
  },
  filetypes = { 'dart' },
  init_options = {
    onlyAnalyzeProjectsWithOpenFiles = false,
    suggestFromUnimportedLibraries = true,
    closingLabels = true,
    outline = false,
    flutterOutline = false,
  },
  settings = {
    dart = {
      analysisExcludedFolders = dartExcludedFolders,
      updateImportsOnRename = true,
      completeFunctionCalls = true,
      showTodos = true,
    },
  },
}
