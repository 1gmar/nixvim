{
  description = "Nixvim config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.11";
    nixvim = {
      url = "github:nix-community/nixvim?ref=nixos-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    topiary = {
      url = "github:tweag/topiary";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    color-themes.url = "github:1gmar/color-themes";
  };

  outputs =
    {
      color-themes,
      nixpkgs,
      nixvim,
      topiary,
      ...
    }:
    let
      colors = color-themes.solarized.light;
      nvim = nixvim.legacyPackages.${system}.makeNixvimWithModule {
        module = ./config;
        inherit pkgs;
        extraSpecialArgs = {
          inherit colors;
          inherit system;
          topiary = {
            lib = topiary.lib.${system};
            inherit (topiary.packages.${system}) topiary-cli;
          };
          tsGrmrPkgs = pkgs.vimPlugins.nvim-treesitter.builtGrammars;
        };
      };
      pkgs = import nixpkgs { inherit system; };
      system = "x86_64-linux";
    in
    {
      checks.${system}.default = nixvim.lib.${system}.check.mkTestDerivationFromNvim {
        inherit nvim;
        name = "Neovim";
      };
      devShells.${system}.default = pkgs.mkShellNoCC {
        packages = [
          (nvim.extend {
            git.enable = true;
            lua.enable = true;
          })
        ];
      };
      formatter.${system} = pkgs.nixfmt;
      inherit (nixvim) lib;
      packages.${system}.default = nvim;
    };
}
