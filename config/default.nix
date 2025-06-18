{lib, ...}: {
  imports = [
    ./completion
    ./file-manager
    ./file-finder
    ./keymappings
    ./languages
    ./text-editing
    ./ui

    ./autocommands.nix
    ./options.nix
  ];

  autocommands.enable = lib.mkDefault true;
  completion.enable = lib.mkDefault true;
  file-finder.enable = lib.mkDefault true;
  file-manager.enable = lib.mkDefault true;
  keymappings.enable = lib.mkDefault true;
  languages.enable = lib.mkDefault true;
  text-editing.enable = lib.mkDefault true;
  ui.enable = lib.mkDefault true;
  vimOpts.enable = lib.mkDefault true;

  plugins.mini.enable = lib.mkDefault true;
}
