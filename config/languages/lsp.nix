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
          mode = "n";
          options.desc = "[g]o to [h]over documentation";
        }
        {
          key = "<leader>gd";
          lspBufAction = "definition";
          mode = "n";
          options.desc = "[g]o to [d]efinition";
        }
        {
          key = "<leader>gD";
          lspBufAction = "declaration";
          mode = "n";
          options.desc = "[g]o to [D]eclaration";
        }
        {
          key = "<leader>gR";
          lspBufAction = "references";
          mode = "n";
          options.desc = "[g]o to [R]eferences";
        }
        {
          key = "<leader>gi";
          lspBufAction = "implementation";
          mode = "n";
          options.desc = "[g]o to [i]mplementation";
        }
        {
          key = "<leader>gt";
          lspBufAction = "type_definition";
          mode = "n";
          options.desc = "[g]o to [t]ype definition";
        }
        {
          key = "<leader>gr";
          lspBufAction = "rename";
          mode = "n";
          options.desc = "[g]o [r]ename";
        }
        {
          key = "<leader>ca";
          lspBufAction = "code_action";
          mode = "n";
          options.desc = "[c]ode [a]ction";
        }
        {
          key = "<leader>gf";
          lspBufAction = "format";
          mode = "n";
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
            nixpkgs.expr = lib.mkDefault "import <nixpkgs> { }";
          };
        };
      };
    };
  };
}
