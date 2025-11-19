{ config, lib, ... }:
{
  imports = [
    ./dap.nix
    ./lsp.nix
    ./none-ls.nix
    ./treesitter.nix
  ];
  options.common = {
    enable = lib.mkEnableOption "enable common module";
  };
  config = lib.mkIf config.common.enable {
    dap.enable = lib.mkDefault true;
    lsp.enable = lib.mkDefault true;
    none-ls.enable = lib.mkDefault true;
    treesitter.enable = lib.mkDefault true;
  };
}
