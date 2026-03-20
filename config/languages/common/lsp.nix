{
  config,
  lib,
  ...
}:
{
  options.lsp = with lib; {
    enable = mkEnableOption "enable lsp module";
    fmtOnSaveExts = mkOption {
      type = with types; listOf str;
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
          key = "<leader>gD";
          lspBufAction = "declaration";
          mode = "n";
          options.desc = "[g]o to [D]eclaration";
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
    plugins = {
      lsp-signature = {
        enable = true;
        settings = {
          doc_lines = 0;
          hint_enable = false;
          toggle_key = "<A-p>";
        };
      };
      telescope = lib.mkIf config.telescope.enable {
        keymaps = {
          "<leader>gd" = {
            action = "lsp_definitions";
            mode = "n";
            options.desc = "[g]o to [d]efinition";
          };
          "<leader>gF" = {
            action = "lsp_document_symbols symbols=function";
            mode = "n";
            options.desc = "[g]o to [F]unctions";
          };
          "<leader>gi" = {
            action = "lsp_implementations";
            mode = "n";
            options.desc = "[g]o to [i]mplementation";
          };
          "<leader>gR" = {
            action = "lsp_references";
            mode = "n";
            options.desc = "[g]o to [R]eferences";
          };
          "<leader>gt" = {
            action = "lsp_type_definitions";
            mode = "n";
            options.desc = "[g]o to [t]ype definition";
          };
        };
        settings.pickers =
          let
            cursor = {
              previewer = false;
              theme = "cursor";
            };
          in
          lib.genAttrs [
            "lsp_definitions"
            "lsp_implementations"
            "lsp_references"
            "lsp_type_definitions"
          ] (_: cursor)
          // {
            lsp_document_symbols = {
              previewer = false;
              theme = "dropdown";
            };
          };
      };
    };
  };
}
