{ config, lib, ... }:
{
  imports = [
    ./ansi-coloring.nix
    ./colorscheme.nix
    ./dashboard.nix
    ./delimiters.nix
    ./icons.nix
    ./options.nix
    ./indentscope.nix
    ./notification.nix
    ./statusline.nix
  ];
  options.ui = {
    enable = lib.mkEnableOption "enable ui module";
  };
  config.ui = lib.mkIf config.ui.enable {
    ansi-coloring.enable = lib.mkDefault true;
    color-scheme.enable = lib.mkDefault true;
    dashboard.enable = lib.mkDefault true;
    delimiters.enable = lib.mkDefault true;
    icons.enable = lib.mkDefault true;
    indentscope.enable = lib.mkDefault true;
    notification.enable = lib.mkDefault true;
    options.enable = lib.mkDefault true;
    statusline.enable = lib.mkDefault true;
  };
}
