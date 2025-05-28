{
  config,
  lib,
  ...
}: {
  options.indent = {
    enable = lib.mkEnableOption "enable indent module";
  };
  config = lib.mkIf config.indent.enable {
    plugins.mini = {
      luaConfig.post = ''
        require('mini.indentscope').gen_animation.quadratic({ easing = 'out', duration = 1000, unit = 'total' })
      '';
      modules.indentscope = {};
    };
  };
}
