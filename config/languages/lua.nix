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
    lsp.servers.lua_ls = {
      enable = true;
      config = {
        cmd = [ "lua-language-server" ];
        filetypes = [ "lua" ];
        root_markers = [
          ".luarc.json"
          ".luarc.jsonc"
          ".luacheckrc"
          ".stylua.toml"
          "stylua.toml"
          "selene.toml"
          "selene.yml"
          ".git"
        ];
        settings.Lua = {
          format = {
            enable = true;
            defaultConfig = {
              indent_style = "space";
              indent_size = "2";
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
  };
}
