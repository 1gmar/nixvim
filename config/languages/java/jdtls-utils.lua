local M = {}

M.get_bundles = function(bundles_path)
  local bundles_glob = vim.fn.glob(bundles_path .. "/*.jar", true)
  return vim.split(bundles_glob, "\n")
end

M.get_capabilities = function()
  local extra_capabilities = {
    textDocument = {
      codeAction = {
        codeActionLiteralSupport = {
          codeActionKind = {
            valueSet = {
              "",
              "quickfix",
              "refactor",
              "refactor.extract",
              "refactor.inline",
              "refactor.rewrite",
              "source",
              "source.fixAll",
              "source.organizeImports",
            }
          }
        }
      }
    }
  }
  return vim.tbl_deep_extend(
    'keep',
    extra_capabilities,
    require('cmp_nvim_lsp').default_capabilities())
end

M.path_for = function(home_var, project)
  local home = os.getenv(home_var)
  return home .. '/jdtls/' .. project
end

local function add_keymaps()
  local keymap, jdtls = vim.keymap.set, require('jdtls')
  keymap('n', '<A-o>', jdtls.organize_imports)
  keymap('n', '<A-S-v>', jdtls.extract_variable)
  keymap('v', '<A-S-v>', function() jdtls.extract_variable(true) end)
  keymap('n', '<A-S-c>', jdtls.extract_constant)
  keymap('v', '<A-S-c>', function() jdtls.extract_constant(true) end)
  keymap('v', '<A-S-m>', function() jdtls.extract_method(true) end)
  keymap('n', '<A-t>', jdtls.test_nearest_method)
  keymap('v', '<A-t>', function() jdtls.test_nearest_method(true) end)
  keymap('n', '<A-S-t>', jdtls.test_class)
end

M.on_attach = function()
  add_keymaps()
  vim.lsp.codelens.refresh()
  vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = { "*.java" },
    callback = function()
      local _, _ = pcall(vim.lsp.codelens.refresh)
    end
  })
end

return M
