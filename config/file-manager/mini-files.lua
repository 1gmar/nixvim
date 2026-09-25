local M = {}
local show_dotfiles = false

local function show_files() return true end
M.hide_files = function(entry) return not vim.startswith(entry.name, '.') end

local function set_filter()
  show_dotfiles = not show_dotfiles
  local filter = show_dotfiles and show_files or M.hide_files
  require('mini.files').refresh({ content = { filter = filter } })
end

M.dotfiles_toggle = function(args)
  vim.keymap.set('n', 'g.', set_filter, { buf = args.data.buf_id })
end

return M
