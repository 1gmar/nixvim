{
  config,
  lib,
  ...
}: {
  options.none-ls = {
    enable = lib.mkEnableOption "enable none-ls module";
  };
  config = lib.mkIf config.none-ls.enable {
    plugins.none-ls = {
      enable = true;
      sources = {
        code_actions = {
          statix.enable = true;
        };
        diagnostics = {
          statix.enable = true;
        };
        formatting = {
          xmllint.enable = true;
        };
      };
    };
  };
}
