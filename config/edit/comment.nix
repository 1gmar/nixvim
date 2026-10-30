{ config, lib, ... }:
{
  options.edit.comment = {
    enable = lib.mkEnableOption "enable comment module";
  };
  config = lib.mkIf config.edit.comment.enable {
    plugins.mini-comment.enable = true;
  };
}
