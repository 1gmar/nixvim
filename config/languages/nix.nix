{
  config,
  lib,
  pkgs,
  system,
  ...
}:
{
  options.nix = {
    enable = lib.mkEnableOption "enable nix module";
  };
  config = lib.mkIf config.nix.enable {
    extraPackages = with pkgs; [ nixfmt ];
    lsp.servers.nixd = {
      enable = true;
      config = {
        cmd = [ "nixd" ];
        filetypes = [ "nix" ];
        root_markers = [
          "flake.nix"
          "git"
        ];
        settings.nixd = {
          formatting.command = lib.mkDefault [ "nixfmt" ];
          nixpkgs.expr = lib.mkDefault "import <nixpkgs> { }";
          options.nixvim.expr = "(builtins.getFlake \"github:1gmar/nixvim\").packages.${system}.default.options";
        };
      };
    };
  };
}
