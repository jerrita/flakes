all: fmt deploy
build:
	nix build .#darwinConfigurations.mac.system --extra-experimental-features 'nix-command flakes' --show-trace --verbose

deploy:
	darwin-rebuild switch --flake .#mac --show-trace --verbose

fmt:
	nix fmt

gc:
  sudo nix profile wipe-history --profile /nix/var/nix/profiles/system --older-than 7d
  sudo nix store gc --debug
