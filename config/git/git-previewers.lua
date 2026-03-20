local from_entry = require('telescope.from_entry')
local previewers = require('telescope.previewers')
local utils = require('telescope.utils')
local M = {}

local function scroll_fn(self, direction)
  if not self.state then
    return
  end
  local bufnr = self.state.termopen_bufnr
  local keycode = direction > 0 and string.char(0x05) or string.char(0x19)
  local count = math.abs(direction)
  vim.api.nvim_win_call(vim.fn.bufwinid(bufnr), function()
    vim.cmd([[normal! ]] .. count .. keycode)
  end)
end

local function diff_to_parent_cmd(entry)
  return { 'git', '--no-pager', 'diff', entry.value .. '^!' }
end

local function diff_to_parent_previewer(get_command)
  return previewers.new_termopen_previewer({
    title = 'Git Diff to Parent Preview',

    get_command = get_command,

    scroll_fn = scroll_fn,
  })
end

M.term_git_commit_message_previewer = previewers.new_termopen_previewer({
  title = 'Git Message',

  get_command = function(entry)
    return { 'git', '--no-pager', 'log', '-n', '1', entry.value }
  end,

  scroll_fn = scroll_fn,
})

M.term_git_local_diff_to_parent_previewer = diff_to_parent_previewer(
  function(entry, status)
    local command = diff_to_parent_cmd(entry)
    local current_file = vim.api.nvim_buf_get_name(status.layout.picker.original_bufnr)
    table.insert(command, '--')
    table.insert(command, current_file)
    return command
  end
)
M.term_git_diff_to_parent_previewer = diff_to_parent_previewer(diff_to_parent_cmd)

M.term_git_status_previewer = previewers.new_termopen_previewer({
  title = 'Git File Diff Preview',

  dyn_title = function(_, entry)
    return entry.value
  end,

  get_command = function(entry)
    local command = { 'git', '--no-pager', 'diff' }

    if entry.status and (entry.status == '??' or entry.status == 'A ') then
      local p = from_entry.path(entry, true, false)
      if p == nil or p == '' then
        return
      end
      table.insert(command, { '--no-index', '/dev/null' })
    else
      table.insert(command, { 'HEAD', '--' })
    end
    return utils.flatten({ utils.flatten(command), entry.value })
  end,

  scroll_fn = scroll_fn,
})

return M
