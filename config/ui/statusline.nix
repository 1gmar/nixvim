{
  config,
  lib,
  ...
}: {
  options.statusline = {
    enable = lib.mkEnableOption "enable statusline module";
  };
  config = lib.mkIf config.statusline.enable {
    plugins.lualine = {
      enable = true;
      settings = {
        extensions = ["man"];
        options = {
          ignore_focus = ["mini-files" "neo-tree"];
          theme = "solarized_light";
        };
        sections.lualine_x.__raw = ''
          {
            "encoding",
            "fileformat",
            "filetype",
            { "lsp_status", ignore_lsp = {"null-ls"} },
          },
        '';
      };
    };
  };
}
