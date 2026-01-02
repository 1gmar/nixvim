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
  };

  outputs =
    {
      nixpkgs,
      nixvim,
      topiary,
      ...
    }:
    let
      colors = {
        background = "#fdf6e3";
        backgroundHigh = "#eee8d5";
        blue = "#268bd2";
        cyan = "#2aa198";
        foreground0 = "#839496";
        foregroundEmph = "#586e75";
        green = "#859900";
        magenta = "#d33682";
        orange = "#cb4b16";
        red = "#dc322f";
        secondaryContent = "#93a1a1";
        text = "#657b83";
        violet = "#6c71c4";
        yellow = "#b58900";
      };
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
      inherit (nixvim) lib;
      packages.${system}.default = nvim;
    };
}
