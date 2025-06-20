{
  config,
  lib,
  pkgs,
  ...
}: {
  options.lsp = {
    enable = lib.mkEnableOption "enable lsp module";
  };
  config = lib.mkIf config.lsp.enable {
    extraPackages = with pkgs; [alejandra];
    plugins.lsp = {
      enable = true;
      inlayHints = false;
      keymaps = {
        diagnostic = {
          "]e" = "goto_next";
          "[e" = "goto_prev";
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
