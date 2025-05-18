{lib, ...}: {
  imports = [
    ./commons
    ./completion
    ./file-browser
    ./file-finder
    ./keymappings
    ./languages
    ./text-editing
    ./ui
  ];

  commons.enable = lib.mkDefault true;
  completion.enable = lib.mkDefault true;
  file-browser.enable = lib.mkDefault true;
  file-finder.enable = lib.mkDefault true;
  keymappings.enable = lib.mkDefault true;
  languages.enable = lib.mkDefault true;
  text-editing.enable = lib.mkDefault true;
  ui.enable = lib.mkDefault true;

  plugins.mini.enable = lib.mkDefault true;
}
