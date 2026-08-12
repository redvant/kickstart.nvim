local pickers = require 'telescope.pickers'
local finders = require 'telescope.finders'
local conf = require('telescope.config').values
local utils = require 'telescope.utils'
local action_state = require 'telescope.actions.state'

local M = {}

local function get_normalized_path(path)
  return vim.fn.fnamemodify(path, ':p'):gsub('\\', '/')
end

local function project_mark_entry_maker(entry)
  local filename = entry.file
  local line = entry.pos[2]
  local col = entry.pos[3]
  local display_string = string.format('%-4s %s:%s', entry.mark, utils.transform_path({}, filename), line)

  return {
    value = entry,
    ordinal = entry.mark .. ' ' .. filename,
    display = display_string,
    filename = filename,
    lnum = line,
    col = col,
  }
end

local function filter_project_marks(opts)
  opts = opts or {}

  local root = require('custom.utils').get_project_root()
  if not root or root == '' then
    print 'No project root found'
    return
  end

  local clean_root = get_normalized_path(root)
  if clean_root:sub(-1) ~= '/' then
    clean_root = clean_root .. '/'
  end

  local raw_marks = vim.fn.getmarklist()
  local filtered_marks = {}

  for _, mark in ipairs(raw_marks) do
    if mark.file and mark.file ~= '' then
      local is_numbered = string.match(mark.mark, "^'%d")
      if not is_numbered then
        local absolute_file = get_normalized_path(mark.file)
        if string.sub(absolute_file, 1, #clean_root) == clean_root then
          table.insert(filtered_marks, mark)
        end
      end
    end
  end

  pickers
    .new(opts, {
      prompt_title = 'Project Marks',
      finder = finders.new_table {
        results = filtered_marks,
        entry_maker = project_mark_entry_maker,
      },
      sorter = conf.generic_sorter(opts),
      previewer = conf.grep_previewer(opts),
      attach_mappings = function(prompt_bufnr, map)
        local delete_mark = function()
          local current_picker = action_state.get_current_picker(prompt_bufnr)

          -- Iterates over each selection
          current_picker:delete_selection(function(selection)
            local mark = selection.value.mark:gsub("'", '')
            local success = vim.api.nvim_del_mark(mark)
            if success then
              return true
            else
              return false
            end
          end)
        end

        map('i', '<A-d>', delete_mark)
        map('n', 'd', delete_mark)

        -- Returning true tells Telescope to keep the default bindings
        -- (like <CR> to select, <Esc> to close). If you return false,
        -- ONLY your custom bindings will work.
        return true
      end,
    })
    :find()
end

M.setup = function()
  vim.keymap.set('n', '<leader>m', filter_project_marks, {
    desc = 'Project [M]arks',
  })
end

return M
