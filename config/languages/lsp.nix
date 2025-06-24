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
    lsp = {
      inlayHints.enable = false;
      keymaps = [
        {
          key = "<leader>gh";
          lspBufAction = "hover";
          options.desc = "[g]o to [h]over documentation";
        }
        {
          key = "<leader>gd";
          lspBufAction = "definition";
          options.desc = "[g]o to [d]efinition";
        }
        {
          key = "<leader>gD";
          lspBufAction = "declaration";
          options.desc = "[g]o to [D]eclaration";
        }
        {
          key = "<leader>gR";
          lspBufAction = "references";
          options.desc = "[g]o to [R]eferences";
        }
        {
          key = "<leader>gi";
          lspBufAction = "implementation";
          options.desc = "[g]o to [i]mplementation";
        }
        {
          key = "<leader>gt";
          lspBufAction = "type_definition";
          options.desc = "[g]o to [t]ype definition";
        }
        {
          key = "<leader>gr";
          lspBufAction = "rename";
          options.desc = "[g]o [r]ename";
        }
        {
          key = "<leader>ca";
          lspBufAction = "code_action";
          options.desc = "[c]ode [a]ction";
        }
        {
          key = "<leader>gf";
          lspBufAction = "format";
          options.desc = "[g]o [f]ormat";
        }
      ];
      servers.nixd = {
        enable = true;
        settings = {
          cmd = ["nixd"];
          filetypes = ["nix"];
          root_markers = ["flake.nix" "git"];
          settings.nixd = {
            formatting.command = ["alejandra"];
            nixpkgs.expr = "import <nixpkgs> { }";
          };
        };
      };
    };
  };
}
