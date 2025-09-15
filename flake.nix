{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-24.11";
    # nixpkgs-openwebui.url = "github:nixos/nixpkgs/20075955deac2583bb12f07151c2df830ef346b4";
    nixpkgs-openwebui.url = "nixpkgs/nixos-unstable";

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

  outputs = { self, nixpkgs, nixpkgs-stable, home-manager, disko, sops-nix, nixpkgs-openwebui, stable-diffusion-webui-nix, ... }@inputs:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;

      commonPkgConfig = {
        inherit system;
        config.allowUnfree = true;
        config.nix.channel.enable = false;
      };

      pkgs = import inputs.nixpkgs commonPkgConfig;
      pkgs-stable = import inputs.nixpkgs-stable commonPkgConfig;
      pkgs-openwebui = import inputs.nixpkgs-openwebui commonPkgConfig;

      # Helper function to create nixosSystem configurations
      mkHost = { hostname, extraModules ? [ ], extraSpecialArgs ? { } }:
        lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/${hostname}/configuration.nix
            { name = hostname; }
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${hostname} = {
                imports = [ ./hosts/${hostname}/home.nix ];
                name = hostname;
              };
            }
            sops-nix.nixosModules.sops
            disko.nixosModules.disko
          ] ++ extraModules;
          specialArgs = {
            inherit inputs pkgs-openwebui pkgs-stable;
          } // extraSpecialArgs;
        };
    in
    {
      nixosConfigurations = {
        v14 = mkHost { hostname = "v14"; };

        p15 = mkHost { hostname = "p15"; };

        hs = mkHost { hostname = "hs"; };

        installer = lib.nixosSystem {
          modules = [
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
