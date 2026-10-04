{ config, lib, ... }:
{
  options.statusline = {
    enable = lib.mkEnableOption "enable statusline module";
    settings = lib.mkOption {
      type = with lib.types; attrsOf anything;
      default = { };
    };
  };
  config = lib.mkIf config.statusline.enable {
    plugins.lualine = {
      enable = true;
      settings = lib.recursiveUpdate {
        extensions = [ "man" ];
        options = {
          ignore_focus = [
            "mini-files"
            "neo-tree"
          ];
          theme = "solarized_light";
        };
        sections = {
          lualine_b = [ "branch" ];
          lualine_c = [
            "diff"
            "filename"
            {
              __unkeyed-1 = "diagnostics";
              diagnostics_color = {
                error = "DiagnosticError";
                hint = "DiagnosticHint";
                info = "DiagnosticInfo";
                warn = "DiagnosticWarn";
              };
            }
          ];
          lualine_x = [
            "encoding"
            "fileformat"
            "filetype"
            {
              __unkeyed-1 = "lsp_status";
              ignore_lsp = [ "null-ls" ];
            }
          ];
          lualine_y = [
            "progress"
            "%L"
          ];
        };
      } config.statusline.settings;
    };
  };
}
