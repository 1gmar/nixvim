{
  config,
  lib,
  ...
}:
{
  imports = [
    ./browser.nix
    ./mini-diff.nix
    ./mini-git.nix
  ];
  options.git = {
    enable = lib.mkEnableOption "enable git module";
  };
  config = lib.mkIf config.git.enable {
    browser.enable = lib.mkDefault true;
    mini-diff.enable = lib.mkDefault true;
    mini-git.enable = lib.mkDefault true;
  };
}
