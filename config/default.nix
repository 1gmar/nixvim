{ lib, ... }:
{
  imports = [
    ./file-manager
    ./git
    ./languages
    ./text-editing
    ./ui

    ./completion.nix
    ./diagnostics.nix
    ./keymappings.nix
    ./options.nix
    ./telescope.nix
  ];

  completion.enable = lib.mkDefault true;
  diagnostic-config.enable = lib.mkDefault true;
  file-manager.enable = lib.mkDefault true;
  git.enable = lib.mkDefault true;
  keymappings.enable = lib.mkDefault true;
  languages.enable = lib.mkDefault true;
  telescope.enable = lib.mkDefault true;
  text-editing.enable = lib.mkDefault true;
  ui.enable = lib.mkDefault true;
  vimOpts.enable = lib.mkDefault true;

  clipboard.providers.xclip.enable = lib.mkDefault true;
}
