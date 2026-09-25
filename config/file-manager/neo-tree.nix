{
  colors,
  config,
  lib,
  ...
}:
{
  options.neo-tree = {
    enable = lib.mkEnableOption "enable neo-tree module";
  };
  config = lib.mkIf config.neo-tree.enable {
    highlightOverride = with colors; {
      NeoTreeFloatTitle = {
        bg = gui.background;
        ctermbg.__raw = toString cterm.background;
        fg = gui.orange;
        ctermfg.__raw = toString cterm.orange;
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
