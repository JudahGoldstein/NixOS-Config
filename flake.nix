{
  description = "package updates";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
    in
    {
      nixosConfigurations = {
        nixos = lib.nixosSystem {
          inherit system;
          modules = [ ./hosts/V14/configuration.nix ];
          specialArgs = {
            pkgs-unstable = pkgs-unstable;
            nixpkgs.config.allowUnfree = true;
          };
        };
      };
      homeConfigurations = {
        v14 = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./hosts/V14/home.nix ];
        };
      };
    };
}
