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
      "https://chaotic-nyx.cachix.org/"
      "https://devenv.cachix.org/"
      "https://cache.nixos-cuda.org"
      "https://numtide.cachix.org"
      "https://om.cachix.org/"
      "https://judah-personal.cachix.org/"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
      "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
      "om.cachix.org-1:ifal/RLZJKN4sbpScyPGqJ2+appCslzu7ZZF/C01f2Q="
      "judah-personal.cachix.org-1:/6xuVNQCy5glYuvsrS0K11Xz1EcDpKr06pHv9Ez0HNk="
    ];
  };

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "nixpkgs/nixpkgs-unstable";
    nixpkgs-openwebui.url = "nixpkgs/3edc4a30ed3903fdf6f90c837f961fa6b49582d1";

    chaotic = {
      url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
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
            inputs.chaotic.nixosModules.default
            inputs.stylix.nixosModules.stylix
            inputs.stable-diffusion-webui-nix.nixosModules.default
            inputs.facter-modules.nixosModules.facter
            ({ config.facter.reportPath = ./hosts/${hostname}/facter.json; })
            ({ nixpkgs.overlays = [ inputs.copyparty.overlays.default ]; })
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

        #   installer = lib.nixosSystem {
        #     inherit system;
        #     modules = [
        #       ./hosts/installer/configuration.nix
        #       inputs.sops-nix.nixosModules.sops
        #     ];
        #     specialArgs = {
        #       inherit inputs;
        #     };
        #   };
      };
    };
}
