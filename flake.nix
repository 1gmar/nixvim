{
  description = "Nixvim config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {nixvim, ...}: let
    config = import ./config;
    nvim = nixvim.legacyPackages.${system}.makeNixvim config;
    system = "x86_64-linux";
  in {
    checks.${system}.default = nixvim.lib.${system}.check.mkTestDerivationFromNvim {
      inherit nvim;
      name = "Neovim";
    };
    homeManagerModules.nixvim = nixvim.homeManagerModules.nixvim;
    inherit (nixvim) legacyPackages;
    nixvimModule = config;
    packages.${system}.default = nvim;
  };
}
