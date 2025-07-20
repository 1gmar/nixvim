{
  config,
  lib,
  ...
}: {
  options.find-and-replace = {
    enable = lib.mkEnableOption "enable find-and-replace module";
  };
  config = lib.mkIf config.find-and-replace.enable {
    keymaps = [
      {
        action = "<cmd>GrugFar<cr>";
        key = "<leader>/";
        mode = ["n"];
      }
      {
        action.__raw = "require('grug-far').with_visual_selection";
        key = "<leader>/";
        mode = ["x"];
      }
      {
        action.__raw = "function() require('grug-far').open({visualSelectionUsage = 'operate-within-range'}) end";
        key = "<leader>v/";
        mode = ["x"];
      }
    ];
    plugins.grug-far.enable = true;
  };
}
