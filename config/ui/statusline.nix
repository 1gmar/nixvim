{
  config,
  lib,
  ...
}: {
  options.statusline = {
    enable = lib.mkEnableOption "enable statusline module";
  };
  config = lib.mkIf config.statusline.enable {
    plugins.lualine = {
      enable = true;
      settings.options.theme = "solarized_light";
    };
  };
}
