{
  config,
  lib,
  ...
}: {
  imports = [
    ./mini-files.nix
    ./neo-tree.nix
  ];
  options.file-manager = {
    enable = lib.mkEnableOption "enable file-manager module";
  };
  config = lib.mkIf config.file-manager.enable {
    mini-files.enable = lib.mkDefault true;
    neo-tree.enable = lib.mkDefault true;
  };
}
