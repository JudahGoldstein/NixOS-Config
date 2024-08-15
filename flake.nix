{
  description = "package updates";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim/nixos-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, nixvim, ... }@inputs:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
    in
    {
      nixosConfigurations = {
        v14 = lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/V14/configuration.nix
            inputs.home-manager.nixosModules.default
          ];
          specialArgs = {
            inherit inputs;
            pkgs-unstable = pkgs-unstable;
            nixpkgs.config.allowUnfree = true;
          };
        };

        p15 = lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/P15/configuration.nix
            inputs.home-manager.nixosModules.default
          ];
          specialArgs = {
            inherit inputs;
            pkgs-unstable = pkgs-unstable;
            nixpkgs.config.allowUnfree = true;
          };
        };
      };

      homeConfigurations = {
        v14 = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./hosts/V14/home.nix
            inputs.nixvim.homeManagerModules.nixvim
          ];
        };

        p15 = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./hosts/P15/home.nix
            inputs.nixvim.homeManagerModules.nixvim
          ];
        };
      };
    };
}
