{
  config,
  lib,
  ...
}: {
  options.mini-files = {
    enable = lib.mkEnableOption "enable mini-files module";
  };
  config = lib.mkIf config.mini-files.enable {
    keymaps = [
      {
        action = "<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>";
        key = "<leader>mf";
        mode = "n";
      }
    ];
    plugins.mini.modules.files = {
      options.use_as_default_explorer = false;
    };
  };
}
