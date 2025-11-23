{
  config,
  lib,
  ...
}:
{
  options.lsp = {
    enable = lib.mkEnableOption "enable lsp module";
    fmtOnSaveExts = lib.mkOption {
      type = with lib.types; listOf str;
      default = [ ];
    };
  };
  config = lib.mkIf config.lsp.enable {
    autoCmd = [
      {
        command = "lua vim.lsp.buf.format()";
        event = [ "BufWritePre" ];
        pattern = map (ext: "*." + ext) config.lsp.fmtOnSaveExts;
      }
    ];
    lsp = {
      inlayHints.enable = false;
      keymaps = [
        {
          key = "<A-p>";
          lspBufAction = "signature_help";
          mode = "n";
          options.desc = "show type signature";
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
    };
    plugins.lsp-signature = {
      enable = true;
      settings = {
        extra_trigger_chars = [
          "("
          ","
        ];
        hint_prefix = "󱄑 ";
        toggle_key = "<A-p>";
      };
    };
  };
}
