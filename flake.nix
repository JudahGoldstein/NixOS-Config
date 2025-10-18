{
  nixConfig = {
    extra-experimental-features = [ "nix-command" "flakes" ];
    download-buffer-size = 536870912; # 512MiB
    auto-optimise-store = true;
    extra-substituters = [
      "https://nix-community.cachix.org/"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-25.05";
    nixpkgs-openwebui.url = "nixpkgs/nixpkgs-unstable";
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
    copyparty = {
      url = "github:9001/copyparty";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;

      # Use legacyPackages for better flake evaluation caching
      pkgs = inputs.nixpkgs.legacyPackages.${system};
      pkgs-stable = inputs.nixpkgs-stable.legacyPackages.${system};
      pkgs-openwebui = import inputs.nixpkgs-openwebui {
        system = system;
        config.allowUnfree = true;
      };

      # Helper function to create nixosSystem configurations
      mkHost = { hostname, extraModules ? [ ], extraSpecialArgs ? { } }:
        lib.nixosSystem {
          inherit system;
          modules = [
            ./nixConf.nix
            ./hosts/${hostname}/configuration.nix
            { name = hostname; }
            inputs.home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${hostname} = {
                imports = [ ./hosts/${hostname}/home.nix ];
                name = hostname;
              };
            }
            inputs.sops-nix.nixosModules.sops
            inputs.disko.nixosModules.disko
            inputs.copyparty.nixosModules.default
            ({ nixpkgs.overlays = [ inputs.copyparty.overlays.default ]; })
          ] ++ extraModules;
          specialArgs = {
            inherit inputs pkgs-openwebui pkgs-stable lib;
          } // extraSpecialArgs;
        };
    in
    {
      nixosConfigurations = {
        v14 = mkHost { hostname = "v14"; };

        p15 = mkHost { hostname = "p15"; };

        hs = mkHost { hostname = "hs"; };

        installer = lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/installer/configuration.nix
            inputs.sops-nix.nixosModules.sops
          ];
          specialArgs = {
            inherit inputs;
          };
        };
      };
    };
}
