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
    system = "x86_64-linux";
    nvim = nixvim.legacyPackages.${system}.makeNixvim (import ./nixvim.nix);
  in {
    checks.${system}.default = nixvim.lib.${system}.check.mkTestDerivationFromNvim {
      inherit nvim;
      name = "Neovim";
    };
    nixosModules.default = nvim;
    packages.${system}.default = nvim;
  };
}
