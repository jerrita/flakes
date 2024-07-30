{
  description = "Jerrita's Nix Configuration";

  nixConfig = {
    substituters = [
      "https://mirrors.ustc.edu.cn/nix-channels/store"
      "https://cache.nixos.org"
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix.url = "github:Mic92/sops-nix";
    disko.url = "github:nix-community/disko";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    disko,
    darwin,
    sops-nix,
    home-manager,
    ...
  }: let
    username = "jerrita";
  in {
    darwinConfigurations."mac" = darwin.lib.darwinSystem rec {
      system = "aarch64-darwin";
      specialArgs = {
        inherit inputs username;
        hostname = "Jerrita-Air";
      };

      modules = [
        ./config.nix
        {
          ismac = true;
          iscn = true;
        }
        ./hosts/mac

        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = specialArgs;
          home-manager.users.${username} = import ./home;
        }
      ];
    };

    # Aliyun, HK
    nixosConfigurations.astral = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs username;
      };
      modules = [
        ./config.nix
        {
          isagent = true;
        }
        ./hosts/astral

        sops-nix.nixosModules.sops
      ];
    };

    # US, Rack Nerd, San Jose
    nixosConfigurations.rana = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs username;
      };
      modules = [
        ./config.nix
        ./hosts/rana

        sops-nix.nixosModules.sops
      ];
    };

    # Home, n5095
    nixosConfigurations.hanabi = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs username;
      };
      modules = [
        ./config.nix
        {
          iscn = true;
          islxc = true;
        }
        ./hosts/hanabi

        sops-nix.nixosModules.sops
      ];
    };

    nixosConfigurations.bootstrap = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./config.nix
        ./hosts/bootstrap
        disko.nixosModules.disko
      ];
    };

    packages.x86_64-linux = {
      image = self.nixosConfigurations.bootstrap.config.system.build.diskoImages;
    };

    formatter."aarch64-darwin" = nixpkgs.legacyPackages."aarch64-darwin".alejandra;
    formatter."x86_64-linux" = nixpkgs.legacyPackages."x86_64-linux".alejandra;
  };
}
