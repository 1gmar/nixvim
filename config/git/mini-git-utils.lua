local M = {}

local function git_blame_align(au_data)
  local win_src = au_data.data.win_source
  local line_nr = math.min(vim.api.nvim_buf_line_count(0), vim.fn.line('.', win_src))
  vim.wo.wrap = false
  vim.fn.winrestview({ topline = vim.fn.line('w0', win_src) })
  vim.api.nvim_win_set_cursor(0, { line_nr, 0 })
  vim.wo[win_src].scrollbind, vim.wo.scrollbind = true, true
end

local function git_blame_trim(au_data)
  local buf_id = vim.fn.winbufnr(au_data.data.win_stdout)
  local trimmed_lines = vim.iter(vim.split(au_data.data.stdout, '\n'))
      :map(function(line) return line:gsub('(%x+)%s[%w%./%-_]*%s*%((.+%w+)%s+%d+%).*', '%1 %2') end)
      :map(function(str, _) return str end)
      :totable()
  vim.api.nvim_buf_set_lines(buf_id, 0, -1, false, trimmed_lines)
end

M.on_blame = function(au_data)
  if au_data.data.git_subcommand ~= 'blame' then
    return
  end
  git_blame_align(au_data)
  git_blame_trim(au_data)
end

M.on_diff = function(au_data)
  local diff_cmds = { 'diff', 'log', 'show' }
  if vim.iter(diff_cmds):all(function(x) return x ~= au_data.data.git_subcommand end) then
    return
  end
  vim.g.baleia.once(vim.fn.winbufnr(au_data.data.win_stdout))
  if vim.bo.filetype == 'diff' then
    vim.bo.syntax = 'off'
  end
end

M.git_blame_toggle = function(ansi_coloring_enabled)
  return function()
    local buf_ids = vim.iter(vim.api.nvim_list_bufs())
        :filter(function(b) return vim.api.nvim_buf_is_loaded(b) end)
        :filter(function(b) return vim.fn.bufname(b):match('^minigit://%d+/.+blame .+$') end)
        :totable()
    if #buf_ids > 0 then
      vim.iter(buf_ids):each(function(b) vim.api.nvim_buf_delete(b, {}) end)
      vim.wo.scrollbind = false
    else
      local opt_color_arg = ansi_coloring_enabled and '--color-by-age' or ''
      vim.cmd('vert lefta Git blame --date=human --show-name ' .. opt_color_arg .. ' -- %')
      vim.cmd('vert res 50')
      if ansi_coloring_enabled then
        vim.g.baleia.once(vim.api.nvim_get_current_buf())
      end
    end
  end
end

M.show_at_cursor = function(ansi_diff)
  return function()
    require('mini.git').show_at_cursor()
    if ansi_diff then
      vim.g.baleia.once(vim.api.nvim_get_current_buf())
    end
  end
end

return M
