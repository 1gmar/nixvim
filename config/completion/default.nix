{
  config,
  lib,
  pkgs,
  ...
}: {
  options.completion = {
    enable = lib.mkEnableOption "enable completion module";
  };
  config = lib.mkIf config.completion.enable {
    plugins = {
      cmp = {
        enable = true;
        autoEnableSources = false;
        settings = {
          formatting = {
            fields = ["abbr" "kind" "menu"];
            expandable_indicator = true;
          };
          mapping = {
            "<C-b>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-e>" = "cmp.mapping.abort()";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<Tab>" = "cmp.mapping.select_next_item()";
            "<S-Tab>" = "cmp.mapping.select_prev_item()";
          };
          snippet.expand = ''
            function(args)
              require('luasnip').lsp_expand(args.body)
            end
          '';
          sources = [
            {
              name = "buffer";
              priority = 4;
            }
            {
              name = "luasnip";
              priority = 3;
            }
            {
              name = "nvim_lsp";
              priority = 10;
            }
            {
              name = "path";
              priority = 5;
            }
          ];
          window = {
            completion = {
              border = "rounded";
            };
            documentation.border = "rounded";
          };
        };
      };
      cmp-buffer.enable = true;
      cmp-nvim-lsp.enable = true;
      cmp_luasnip.enable = true;
      cmp-path.enable = true;
      friendly-snippets.enable = true;
      lspkind = {
        enable = true;
        cmp = {
          enable = true;
          menu = {
            nvim_lsp = "[LSP]";
            nvim_lua = "[API]";
            path = "[PATH]";
            luasnip = "[SNIP]";
            buffer = "[BUFFER]";
          };
        };
      };
      luasnip = {
        enable = true;
        fromVscode = [
          {
            lazyLoad = true;
            paths = "${pkgs.vimPlugins.friendly-snippets}";
          }
        ];
      };
    };
  };
}
