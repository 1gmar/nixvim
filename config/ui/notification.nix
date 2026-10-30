{ config, lib, ... }:
{
  options.ui.notification = {
    enable = lib.mkEnableOption "enable notification module";
  };
  config = lib.mkIf config.ui.notification.enable {
    extraConfigLuaPost = ''
      vim.notify = require('mini.notify').make_notify()
    '';
    plugins.mini-notify = {
      enable = true;
      settings.lsp_progress.enable = false;
    };
  };
}
