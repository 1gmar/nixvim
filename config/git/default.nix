{
  config,
  lib,
  ...
}: {
  imports = [
    ./mini-diff.nix
  ];
  options.git = {
    enable = lib.mkEnableOption "enable git module";
  };
  config = lib.mkIf config.git.enable {
    mini-diff.enable = lib.mkDefault true;
  };
}
