{
  config,
  lib,
  ...
}: {
  imports = [
    ./colorscheme.nix
    ./dashboard.nix
    ./delimiters.nix
    ./icons.nix
    ./indent.nix
    ./mini-notify.nix
    ./statusline.nix
  ];
  options.ui = {
    enable = lib.mkEnableOption "enable ui module";
  };
  config = lib.mkIf config.ui.enable {
    color-scheme.enable = lib.mkDefault true;
    dashboard.enable = lib.mkDefault true;
    delimiters.enable = lib.mkDefault true;
    icons.enable = lib.mkDefault true;
    indent.enable = lib.mkDefault true;
    mini-notify.enable = lib.mkDefault true;
    statusline.enable = lib.mkDefault true;
  };
}
