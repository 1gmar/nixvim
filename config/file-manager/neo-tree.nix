{
  config,
  lib,
  ...
}: {
  options.neo-tree = {
    enable = lib.mkEnableOption "enable neo-tree module";
  };
  config = lib.mkIf config.neo-tree.enable {
    keymaps = [
      {
        action = "<cmd>Neotree reveal toggle<CR>";
        key = "<leader>n";
        mode = "n";
      }
      {
        action = "<cmd>Neotree buffers reveal toggle<CR>";
        key = "<leader>bn";
        mode = "n";
      }
      {
        action = "<cmd>Neotree git_status reveal toggle<CR>";
        key = "<leader>gn";
        mode = "n";
      }
    ];
    plugins.neo-tree = {
      enable = true;
      popupBorderStyle = "rounded";
      window.position = "right";
    };
  };
}
