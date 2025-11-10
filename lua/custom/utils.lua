local M = {}

---Loads and convines the returned tables of all the files in a module directory
---@param modname string
---@return table<any, any>
function M.loader(modname)
  -- subtitute . for @ to be able to split modname
  local module_parts = vim.split(modname:gsub('%.', '@'), '@')
  local path = vim.fs.joinpath(vim.fn.stdpath 'config', 'lua', unpack(module_parts))
  local files = vim.fn.glob(path .. '/*.lua', true, true)

  local result = {}
  for _, pair in ipairs(files) do
    -- remove absolute path and extension
    local mod = pair:sub(#path + 2, #pair - 4)
    -- concat to modname
    local module = modname .. '.' .. mod
    vim.list_extend(result, require(module))
  end
  return result
end

---Builds a table with the keys of the map returned by all the files in a module directory
---@param modname string
---@return table<any, any>
function M.builder(modname)
  -- subtitute . for @ to be able to split modname
  local module_parts = vim.split(modname:gsub('%.', '@'), '@')
  local path = vim.fs.joinpath(vim.fn.stdpath 'config', 'lua', unpack(module_parts))
  local files = vim.fn.glob(path .. '/*.lua', true, true)

  local result = {}
  for _, pair in ipairs(files) do
    -- remove absolute path and extension
    local mod = pair:sub(#path + 2, #pair - 4)
    -- concat to modname
    local module = modname .. '.' .. mod
    local module_table = require(module)
    -- we use deep extend to combine all the keys in the maps, if
    -- there is an overlap, 'force' will use the rightmost map's value
    result = vim.tbl_deep_extend('force', result, module_table)
  end
  return result
end

return M
