local M = {}

M.git_blame_align = function(au_data)
  if au_data.data.git_subcommand ~= 'blame' then return end

  local win_src = au_data.data.win_source
  local line_nr = math.min(vim.api.nvim_buf_line_count(0), vim.fn.line('.', win_src))
  vim.wo.wrap = false
  vim.fn.winrestview({ topline = vim.fn.line('w0', win_src) })
  vim.api.nvim_win_set_cursor(0, { line_nr, 0 })
  vim.wo[win_src].scrollbind, vim.wo.scrollbind = true, true
end

M.git_blame_trim = function(au_data)
  if au_data.data.git_subcommand ~= 'blame' then return end

  local buf_id = vim.fn.winbufnr(au_data.data.win_stdout)
  local trimmed_lines = vim.iter(vim.split(au_data.data.stdout, '\n'))
      :map(function(line) return line:gsub('(%x+)%s[%w%./%-_]+%s+%((.+%w+)%s+%d+%).*', '%1 %2') end)
      :map(function(str, _) return str end)
      :totable()
  vim.api.nvim_buf_set_lines(buf_id, 0, -1, false, trimmed_lines)
end

M.git_blame_toggle = function()
  local buf_ids = vim.iter(vim.api.nvim_list_bufs())
      :filter(function(b) return vim.api.nvim_buf_is_loaded(b) end)
      :filter(function(b) return vim.fn.bufname(b):match('^minigit://%d+/git blame .+$') end)
      :totable()
  if #buf_ids > 0 then
    vim.iter(buf_ids):each(function(b) vim.api.nvim_buf_delete(b, {}) end)
  else
    vim.cmd('MiniGitBlame')
  end
end

return M
