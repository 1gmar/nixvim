{
  colors,
  config,
  lib,
  ...
}: {
  options.diagnostic-config = {
    enable = lib.mkEnableOption "enable diagnostic-config module";
  };
  config = lib.mkIf config.diagnostic-config.enable {
    diagnostic.settings = {
      severity_sort = true;
      signs = {
        __raw = ''
          {
            linehl = {
              [vim.diagnostic.severity.ERROR] = "DiagnosticErrorLine",
              [vim.diagnostic.severity.WARN] = "DiagnosticWarnLine",
            },
            text = {
              [vim.diagnostic.severity.ERROR] = "",
              [vim.diagnostic.severity.HINT] = "",
              [vim.diagnostic.severity.INFO] = "",
              [vim.diagnostic.severity.WARN] = "",
            },
          }
        '';
      };
      underline = true;
      update_in_insert = false;
      virtual_lines = false;
      virtual_text = false;
    };
    highlightOverride = with colors; {
      DiagnosticErrorLine = {
        bg = background;
        fg = orange;
        reverse = true;
      };
      DiagnosticWarnLine = {
        bg = background;
        fg = yellow;
        reverse = true;
      };
    };
  };
}
