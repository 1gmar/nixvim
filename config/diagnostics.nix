{
  config,
  lib,
  ...
}: {
  options.diagnostic-config = {
    enable = lib.mkEnableOption "enable diagnostic-config module";
  };
  config = lib.mkIf config.diagnostic-config.enable {
    diagnostic.settings = {
      signs = true;
      underline = true;
      update_in_insert = false;
      virtual_lines = false;
      virtual_text = true;
    };
    keymaps = [
      {
        action = "<cmd>lua vim.diagnostic.goto_next()<CR>";
        key = "]e";
        mode = "n";
      }
      {
        action = "<cmd>lua vim.diagnostic.goto_prev()<CR>";
        key = "[e";
        mode = "n";
      }
    ];
  };
}
