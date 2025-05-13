{
  config,
  lib,
  ...
}: {
  options.lsp = {
    enable = lib.mkEnableOption "enable lsp module";
  };
  config = lib.mkIf config.lsp.enable {
    plugins.lsp = {
      enable = true;
      inlayHints = false;
      keymaps = {
        diagnostic = {
          "<leader>eo" = "open_float";
          "]e" = "goto_next";
          "[e" = "goto_prev";
          "<leader>ee" = "show";
        };
        lspBuf = {
          K = "hover";
          gd = "definition";
          gD = "declaration";
          gr = "references";
          gi = "implementation";
          gt = "type_definition";
          "<leader>rn" = "rename";
          "<leader>ca" = "code_action";
          "<leader>gf" = "format";
        };
      };
      servers.nixd = {
        enable = true;
        settings = {
          formatting.command = ["alejandra"];
          nixpkgs.expr = "import <nixpkgs> { }";
        };
      };
    };
  };
}
