{
  description = "package updates";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-24.11";
    nixpkgs-pin.url = "github:nixos/nixpks/1fd8bada0b6117e6c7eb54aad5813023eed37ccb";
    # nixpkgs-pin.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stable-diffusion-webui-nix = {
      url = "github:Janrupf/stable-diffusion-webui-nix/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, nixpkgs-stable, home-manager, disko, sops-nix, nixpkgs-pin, stable-diffusion-webui-nix, ... }@inputs:
    let
      system = "x86_64-linux";

      lib = nixpkgs.lib;

      pkgs = import inputs.nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
        config.nix.channel.enable = false;
        config.permittedInsecurePackages =
          [
            "aspnetcore-runtime-wrapped-6.0.36" #sonarr
            "aspnetcore-runtime-6.0.36" #sonarr
            "dotnet-sdk-wrapped-6.0.428" #sonarr
            "dotnet-sdk-6.0.428" #sonarr
          ];
      };
      pkgs-stable = import inputs.nixpkgs-stable {
        system = "x86_64-linux";
        config.allowUnfree = true;
        config.nix.channel.enable = false;
        config.permittedInsecurePackages =
          [
            "aspnetcore-runtime-wrapped-6.0.36" #sonarr
            "aspnetcore-runtime-6.0.36" #sonarr
            "dotnet-sdk-wrapped-6.0.428" #sonarr
            "dotnet-sdk-6.0.428" #sonarr
          ];
      };
    in
    {
      nixosConfigurations = {
        v14 = lib.nixosSystem {
          inherit system;
          modules =
            [
              ./hosts/v14/configuration.nix
              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.v14 = ./hosts/v14/home.nix;
              }
              sops-nix.nixosModules.sops
            ];
          specialArgs = {
            inherit inputs;
          };
        };

        p15 = lib.nixosSystem {
          inherit system;
          modules =
            [
              ./hosts/p15/configuration.nix
              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.p15 = ./hosts/p15/home.nix;
              }
              sops-nix.nixosModules.sops
            ];
          specialArgs = {
            inherit inputs;
          };
        };

        hs = lib.nixosSystem {
          inherit system;
          modules =
            [
              ./hosts/hs/configuration.nix
              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.hs = ./hosts/hs/home.nix;
              }
              sops-nix.nixosModules.sops
              disko.nixosModules.disko
            ];
          specialArgs = {
            inherit inputs;
            pkgs-pin = import nixpkgs-pin {
              inherit system;
              config.allowUnfree = true;
            };
            inherit pkgs-stable;
          };
        };

        installer = lib.nixosSystem {
          modules =
            [
              ./hosts/installer/configuration.nix
              sops-nix.nixosModules.sops
            ];
          specialArgs = {
            inherit inputs;
          };
        };
      };
    };
}
