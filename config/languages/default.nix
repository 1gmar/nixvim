{ config, lib, ... }:
{
  imports = [
    ./java

    ./dap.nix
    ./lsp.nix
    ./lua.nix
    ./nix.nix
    ./none-ls.nix
    ./nushell.nix
    ./prolog.nix
    ./treesitter.nix
  ];
  options.languages = {
    enable = lib.mkEnableOption "enable languages module";
  };
  config.languages = lib.mkIf config.languages.enable {
    dap.enable = lib.mkDefault true;
    lsp.enable = lib.mkDefault true;
    none-ls.enable = lib.mkDefault true;
    treesitter.enable = lib.mkDefault true;

    java.enable = lib.mkDefault false;
    lua.enable = lib.mkDefault false;
    nix.enable = lib.mkDefault true;
    nushell.enable = lib.mkDefault false;
    prolog.enable = lib.mkDefault false;
  };
}
