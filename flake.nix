{
  description = "package updates";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
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

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, disko, sops-nix, stable-diffusion-webui-nix, ... }@inputs:
    let
      system = "x86_64-linux";

      lib = nixpkgs.lib;

      pkgs = import inputs.nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
        config.nix.channel.enable = false;
      };
      pkgs-unstable = import inputs.nixpkgs-unstable {
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
              inputs.home-manager.nixosModules.default
              sops-nix.nixosModules.sops
            ];
          specialArgs = {
            inherit inputs;
            inherit pkgs-unstable;
          };
        };

        p15 = lib.nixosSystem {
          inherit system;
          modules =
            [
              ./hosts/p15/configuration.nix
              inputs.home-manager.nixosModules.default
              sops-nix.nixosModules.sops
            ];
          specialArgs = {
            inherit inputs;
            inherit pkgs-unstable;
          };
        };

        hs = lib.nixosSystem {
          inherit system;
          modules =
            [
              ./hosts/hs/configuration.nix
              inputs.home-manager.nixosModules.default
              sops-nix.nixosModules.sops
              disko.nixosModules.disko
            ];
          specialArgs = {
            inherit inputs;
            inherit pkgs-unstable;
            inherit stable-diffusion-webui-nix;
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
            inherit pkgs-unstable;
          };
        };
      };

      homeConfigurations = {
        v14 = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules =
            [
              ./hosts/v14/home.nix
              sops-nix.homeManagerModules.sops
            ];
        };

        p15 = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules =
            [
              ./hosts/p15/home.nix
              sops-nix.homeManagerModules.sops
            ];
          extraSpecialArgs = { inherit pkgs-unstable; };
        };

        hs = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules =
            [
              ./hosts/hs/home.nix
              sops-nix.homeManagerModules.sops
            ];
          extraSpecialArgs = { inherit pkgs-unstable; };
        };
      };
    };
}
