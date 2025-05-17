{
  config,
  lib,
  ...
}: {
  options.file-finder = {
    enable = lib.mkEnableOption "enable file-finder module";
  };
  config = lib.mkIf config.file-finder.enable {
    plugins.telescope = {
      enable = true;
      extensions = {
        live-grep-args.enable = true;
        ui-select.enable = true;
      };
      keymaps = {
        "<leader>ff" = {
          action = "find_files";
          mode = "n";
        };
        "<leader>fg" = {
          action = "live_grep";
          mode = "n";
        };
        "<leader>fb" = {
          action = "buffers";
          mode = "n";
        };
        "<leader>fh" = {
          action = "help_tags";
          mode = "n";
        };
      };
    };
  };
}
