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
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nixos anywhere
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
        ismac = true;
        iscn = true;
      };

      modules = [
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

    nixosConfigurations.astral = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs username;
        ismac = false;
        iscn = false;
      };
      modules = [
        ./hosts/astral

        sops-nix.nixosModules.sops
      ];
    };

    nixosConfigurations.bootstrap = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        ismac = false;
        iscn = false;
      };
      modules = [
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
