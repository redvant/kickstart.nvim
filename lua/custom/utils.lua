local M = {}

---Loads and convines the returned tables of all the files in a module directory
---@param modname string
---@param filters table<any, boolean>|nil
---@return table<any, any>
function M.loader(modname, filters)
  -- subtitute . for @ to be able to split modname
  local module_parts = vim.split(modname:gsub('%.', '@'), '@')
  local path = vim.fs.joinpath(vim.fn.stdpath 'config', 'lua', unpack(module_parts))
  local files = vim.fn.glob(path .. '/*.lua', true, true)

  local result = {}
  for _, pair in ipairs(files) do
    -- remove absolute path and extension
    local mod = pair:sub(#path + 2, #pair - 4)
    -- apply filters if provided
    if not filters or filters[mod] then
      -- concat to modname
      local module = modname .. '.' .. mod
      vim.list_extend(result, require(module))
    end
  end
  return result
end

---Builds a table with the keys of the map returned by all the files in a module directory
---@param modname string
---@param filters table<any, boolean>|nil
---@return table<any, any>
function M.builder(modname, filters)
  -- subtitute . for @ to be able to split modname
  local module_parts = vim.split(modname:gsub('%.', '@'), '@')
  local path = vim.fs.joinpath(vim.fn.stdpath 'config', 'lua', unpack(module_parts))
  local files = vim.fn.glob(path .. '/*.lua', true, true)

  local result = {}
  for _, pair in ipairs(files) do
    -- remove absolute path and extension
    local mod = pair:sub(#path + 2, #pair - 4)
    -- apply filters if provided
    if not filters or filters[mod] then
      -- concat to modname
      local module = modname .. '.' .. mod
      local module_table = require(module)
      -- we use deep extend to combine all the keys in the maps, if
      -- there is an overlap, 'force' will use the rightmost map's value
      result = vim.tbl_deep_extend('force', result, module_table)
    end
  end
  return result
end

---Returns project root directory or current working directoy if doesn't found the root
---@return string?
function M.get_project_root()
  local project_markers = { '.git', '.nvim.lua' }
  vim.list_extend(project_markers, M.loader 'custom.project-markers')

  local root = vim.fs.root(0, project_markers)

  if root then
    return root
  end

  return vim.uv.cwd()
end

---Builds a set from an array table
---@param array table<any>
---@return table<any, true>
function M.new_Set(array)
  local set = {}
  for _, pair in ipairs(array) do
    set[pair] = true
  end
  return set
end

return M
