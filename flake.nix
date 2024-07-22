{
  description = "Jerrita's Nix Configuration";

  nixConfig = {
    substituters = [
      "https://mirrors.ustc.edu.cn/nix-channels/store"
      "https://cache.nixos.org"
    ];
  };

  inputs = {
    # nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-24.05-darwin";
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };
    home-manager-darwin = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    darwin,
    home-manager-darwin,
    ...
  }: let
    username = "jerrita";
  in rec {
    darwinConfigurations."mac" = darwin.lib.darwinSystem rec {
      system = "aarch64-darwin";
      specialArgs = {
        inherit inputs username;
        hostname = "Jerrita-Air";
        homedir = "/Users/${username}";
      };

      modules = [
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

    formatter."aarch64-darwin" = nixpkgs.legacyPackages."aarch64-darwin".alejandra;
  };
}
