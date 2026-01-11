{
  nixConfig = {
    extra-experimental-features = [
      "nix-command"
      "flakes"
    ];
    download-buffer-size = 536870912; # 512MiB
    auto-optimise-store = true;
    extra-substituters = [
      "https://nix-community.cachix.org/"
      "https://cache.nixos-cuda.org"
      "https://numtide.cachix.org"
      "https://zed.cachix.org"
      "https://cache.nixos.asia/oss" # for om in gh actions
      "https://om.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
      "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
      "zed.cachix.org-1:/pHQ6dpMsAZk2DiP4WCL0p9YDNKWj2Q5FL20bNmw1cU="
      "oss:KO872wNJkCDgmGN3xy9dT89WAhvv13EiKncTtHDItVU="
      "om.cachix.org-1:ifal/RLZJKN4sbpScyPGqJ2+appCslzu7ZZF/C01f2Q="
    ];
  };

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable-small";
    nixpkgs-openwebui.url = "nixpkgs/nixos-unstable-small";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    facter-modules = {
      url = "github:numtide/nixos-facter-modules";
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
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;

      # Use legacyPackages for better flake evaluation caching
      pkgs = inputs.nixpkgs.legacyPackages.${system};
      pkgs-stable = inputs.nixpkgs-stable.legacyPackages.${system};
      pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.${system};
      pkgs-openwebui = import inputs.nixpkgs-openwebui {
        system = system;
        config.allowUnfree = true;
      };

      # Helper function to recursively import NixOS modules from a list of paths
      recursivelyImport = import ./helpers/recursivelyImport.nix { inherit lib; };

      # Helper function to create nixosSystem configurations
      mkHost =
        {
          hostname,
          extraModules ? [ ],
          extraSpecialArgs ? { },
        }:
        lib.nixosSystem {
          inherit system;
          modules = [
            { name = hostname; }
            inputs.home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "nixbak";
                overwriteBackup = true;
              };
            }
            (lib.mkAliasOptionModule [ "hm" ] [ "home-manager" "users" "${hostname}" ])
            inputs.sops-nix.nixosModules.sops
            inputs.disko.nixosModules.disko
            inputs.copyparty.nixosModules.default
            inputs.stylix.nixosModules.stylix
            inputs.stable-diffusion-webui-nix.nixosModules.default
            inputs.facter-modules.nixosModules.facter
            { config.facter.reportPath = ./hosts/${hostname}/facter.json; }
            { nixpkgs.overlays = [ inputs.copyparty.overlays.default ]; }
            ./defaultConfig.nix
          ]
          ++ extraModules
          ++ recursivelyImport [
            ./modules
            ./hosts/${hostname}
          ];
          specialArgs = {
            inherit
              inputs
              pkgs-stable
              pkgs-unstable
              pkgs-openwebui
              ;
          }
          // extraSpecialArgs;
        };
    in
    {
      nixosConfigurations = {
        v14 = mkHost { hostname = "v14"; };
        p15 = mkHost { hostname = "p15"; };
        hs = mkHost { hostname = "hs"; };
      };
    };
}
