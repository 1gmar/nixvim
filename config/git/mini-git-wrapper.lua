local args = { unpack(arg, 1, #arg) }
local index, subcmd = vim.iter(ipairs(args))
    :find(function(_, x) return string.match(x, '^%l+%-?%l+%-?%l+$') end)

if vim.iter({ 'log', 'show' }):any(function(x) return x == subcmd end) then
  table.insert(args, index + 1, '--ext-diff')
end
table.insert(args, 1, 'git')

local res = vim.system(args, { env = { DFT_WIDTH = '200' }, text = true }):wait()
if res.stdout then
  io.stdout:write(res.stdout)
end
if res.stderr then
  io.stderr:write(res.stderr)
end
