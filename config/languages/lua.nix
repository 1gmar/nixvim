{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.lua = {
    enable = lib.mkEnableOption "enable lua module";
  };
  config = lib.mkIf config.lua.enable {
    autoCmd = [
      {
        command = "lua vim.lsp.buf.format()";
        event = [ "BufWritePre" ];
        pattern = [ "*.lua" ];
      }
    ];
    lsp.servers.lua_ls = {
      enable = true;
      config = {
        cmd = [ "lua-language-server" ];
        filetypes = [ "lua" ];
        root_markers = [
          ".git"
          ".luarc.json"
          ".luarc.jsonc"
          ".luacheckrc"
          ".stylua.toml"
          "stylua.toml"
          "selene.toml"
          "selene.yml"
        ];
        settings.Lua = {
          format = {
            enable = true;
            defaultConfig = {
              auto_collapse_lines = "true";
              break_all_list_when_line_exceed = "true";
              end_of_line = "unset";
              indent_style = "space";
              indent_size = "2";
              max_line_length = "100";
            };
          };
          runtime = {
            path = [
              "lua/?.lua"
              "lua/?/init.lua"
            ];
            version = "LuaJIT";
          };
          workspace = {
            checkThirdParty = false;
            library = [ "${pkgs.neovim-unwrapped}/share/nvim/runtime" ];
          };
        };
      };
    };
    plugins.treesitter.grammarPackages = [ pkgs.vimPlugins.nvim-treesitter.builtGrammars.lua ];
  };
}
