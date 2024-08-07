{
  config,
  lib,
  ...
}: {
  nix.settings = {
    # enable flakes globally
    experimental-features = ["nix-command" "flakes"];

    # substituers that will be considered before the official ones(https://cache.nixos.org)
    substituters =
      [
        "https://jerrita.cachix.org"
        "https://nix-community.cachix.org"
      ]
      ++ (
        if config.iscn
        then [
          "https://mirrors.ustc.edu.cn/nix-channels/store"
        ]
        else []
      );
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "jerrita.cachix.org-1:nuNrOWU7/dWbGwwE5bwUfvycsiPHb5NnD/aIZIcaPDI="
    ];
    builders-use-substitutes = true;
  };
}
