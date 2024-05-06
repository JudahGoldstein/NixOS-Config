{
    description = "package updates";
    inputs = {
        nixpkgs.url = "nixpkgs/nixos-unstable";
        home-manager.url = "github:nix-community/home-manager/master";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
    };
    outputs = {self, nixpkgs, home-manager, ...}:
    let
        lib = nixpkgs.lib;
        system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.${system};
    in {
        nixosConfigurations = {
            nixos = lib.nixosSystem {
                inherit system;
                modules = [ ./hosts/V14/configuration.nix ];
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
