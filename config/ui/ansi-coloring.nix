{ config, lib, ... }:
{
  options.ui.ansi-coloring = {
    enable = lib.mkEnableOption "enable ansi-coloring module";
  };
  config = lib.mkIf config.ui.ansi-coloring.enable {
    plugins.baleia = {
      enable = true;
      luaConfig.pre = "vim.g.baleia = ";
    };
    userCommands."AnsiColorize" = {
      bang = true;
      command = "lua vim.g.baleia.once(vim.api.nvim_get_current_buf())";
    };
  };
}
