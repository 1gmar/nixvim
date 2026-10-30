{
  colors,
  config,
  lib,
  ...
}:
{
  options.file-manager.neo-tree = {
    enable = lib.mkEnableOption "enable neo-tree module";
  };
  config = lib.mkIf config.file-manager.neo-tree.enable {
    highlightOverride = with colors; {
      NeoTreeFloatTitle = {
        bg = gui.background;
        ctermbg.__raw = cterm.backHighlight;
        fg = gui.orange;
        ctermfg.__raw = cterm.orange;
      };
    };
    keymaps = [
      {
        action = "<cmd>Neotree reveal toggle<CR>";
        key = "<leader>n";
        mode = "n";
      }
    ];
    plugins.neo-tree = {
      enable = true;
      settings = {
        filesystem.hijack_netrw_behavior = "open_default";
        popup_border_style = "rounded";
        window.position = "right";
      };
    };
  };
}
