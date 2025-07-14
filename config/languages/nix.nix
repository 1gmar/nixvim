{
  config,
  lib,
  pkgs,
  ...
}: {
  options.nix = {
    enable = lib.mkEnableOption "enable nix module";
  };
  config = lib.mkIf config.nix.enable {
    extraPackages = with pkgs; [alejandra];
    lsp.servers.nixd = {
      enable = true;
      settings = {
        cmd = ["nixd"];
        filetypes = ["nix"];
        root_markers = ["flake.nix" "git"];
        settings.nixd = {
          formatting.command = lib.mkDefault ["alejandra"];
          nixpkgs.expr = lib.mkDefault "import <nixpkgs> { }";
        };
      };
    };
  };
}
