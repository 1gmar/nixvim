{ config, lib, ... }:
{
  options.mini-files = {
    enable = lib.mkEnableOption "enable mini-files module";
  };
  config = lib.mkIf config.mini-files.enable {
    autoCmd = [
      {
        callback.__raw = "require('mini-files').dotfiles_toggle";
        event = "User";
        pattern = [ "MiniFilesBufferCreate" ];
      }
    ];
    extraFiles = {
      "lua/mini-files.lua".source = ./mini-files.lua;
    };
    keymaps = [
      {
        action = "<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>";
        key = "<leader>mf";
        mode = "n";
      }
    ];
    plugins.mini-files = {
      enable = true;
      settings = {
        content.filter.__raw = "require('mini-files').hide_files";
        options.use_as_default_explorer = false;
      };
    };
  };
}
