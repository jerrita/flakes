{
  description = "Jerrita's Nix Configuration";

  nixConfig = {
    substituters = [
      "https://mirrors.ustc.edu.cn/nix-channels/store"
      "https://cache.nixos.org"
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-24.05-darwin";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager-darwin = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    nur.url = "github:nix-community/NUR";
    sops-nix.url = "github:Mic92/sops-nix";
    disko.url = "github:nix-community/disko";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nixpkgs-darwin,
    nixpkgs-unstable,
    disko,
    darwin,
    sops-nix,
    nur,
    home-manager,
    home-manager-darwin,
    ...
  }: let
    username = "jerrita";
  in {
    darwinConfigurations."mac" = darwin.lib.darwinSystem rec {
      system = "aarch64-darwin";
      specialArgs = {
        inherit inputs username;
        hostname = "Jerrita-Air";
        unstable = import nixpkgs-unstable {
          inherit system;
        };
      };

      modules = [
        ./config.nix
        {
          ismac = true;
          iscn = true;
        }
        ./hosts/mac

        home-manager-darwin.darwinModules.home-manager
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
        nur.nixosModules.nur
        ./config.nix
        {
          useWg = true;
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
    nixosConfigurations.aris = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs username;
      };
      modules = [
        nur.nixosModules.nur
        ./config.nix
        {
          iscn = true;
          islxc = true;
        }
        ./hosts/aris

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
