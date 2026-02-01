{
  config,
  lib,
  ...
}:
{
  options.statusline = {
    enable = lib.mkEnableOption "enable statusline module";
  };
  config = lib.mkIf config.statusline.enable {
    plugins.lualine = {
      enable = true;
      settings = {
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
            "diagnostics"
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
      };
    };
  };
}
