{
  config,
  lib,
  ...
}: {
  options.file-browser = {
    enable = lib.mkEnableOption "enable file-browser module";
  };
  config = lib.mkIf config.file-browser.enable {
    plugins.neo-tree = {
      enable = true;
      popupBorderStyle = "rounded";
      window.position = "right";
    };
  };
}
