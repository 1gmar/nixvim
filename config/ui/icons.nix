{
  config,
  lib,
  ...
}:
{
  options.icons = {
    enable = lib.mkEnableOption "enable icons module";
  };
  config = lib.mkIf config.icons.enable {
    plugins.web-devicons = {
      enable = true;
      settings = {
        override_by_extension = lib.nixvim.utils.toRawKeys {
          "\"pl\"" = {
            icon = "";
            color = "#725C2A";
            cterm_color = "94";
            name = "Prolog";
          };
        };
        strict = true;
      };
    };
  };
}
