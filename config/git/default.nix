{
  config,
  lib,
  ...
}: {
  imports = [
    ./mini-diff.nix
    ./mini-git.nix
  ];
  options.git = {
    enable = lib.mkEnableOption "enable git module";
  };
  config = lib.mkIf config.git.enable {
    mini-diff.enable = lib.mkDefault true;
    mini-git.enable = lib.mkDefault true;
  };
}
