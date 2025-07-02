{
  config,
  lib,
  ...
}: {
  options.mini-notify = {
    enable = lib.mkEnableOption "enable mini-notify module";
  };
  config = lib.mkIf config.mini-notify.enable {
    extraConfigLuaPost = ''
      vim.notify = require('mini.notify').make_notify()
    '';
    plugins.mini.modules.notify = {
      lsp_progress.enable = false;
    };
  };
}
