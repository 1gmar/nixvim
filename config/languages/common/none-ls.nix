{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.none-ls = {
    enable = lib.mkEnableOption "enable none-ls module";
  };
  config = lib.mkIf config.none-ls.enable {
    lsp.fmtOnSaveExts = [
      "css"
      "html"
      "json"
      "jsonc"
      "toml"
      "xml"
      "yaml"
      "yml"
    ];
    extraPackages = [ pkgs.tombi ];
    plugins.none-ls = {
      enable = true;
      luaConfig.post = ''
        local null_ls = require('null-ls')
        null_ls.register({
          name = 'tombi',
          method = null_ls.methods.FORMATTING,
          filetypes = { 'toml' },
          generator = null_ls.formatter({
            args = { 'format', '--offline', '-' },
            command = 'tombi',
            to_stdin = true,
          }),
        })
      '';
      sources.formatting = {
        prettier = {
          enable = true;
          settings = {
            filetypes = [
              "css"
              "html"
              "json"
              "jsonc"
              "yaml"
            ];
          };
        };
        xmllint.enable = true;
      };
    };
  };
}
