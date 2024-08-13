OS := `uname -s`

# ------------------ Hosts ----------------------
all: build
fmt:
	nix fmt

build: fmt
    #!/usr/bin/env sh
    if [[ "{{OS}}" = "Darwin" ]]; then
        if [ ! -f ./result/sw/bin/darwin-rebuild ]; then
            nix build .#darwinConfigurations.mac.system --extra-experimental-features 'nix-command flakes' --show-trace --verbose
        fi
        ./result/sw/bin/darwin-rebuild switch --flake .#mac --show-trace --verbose
    else
        sudo nixos-rebuild switch --flake . -L
    fi

gc:
    sudo nix profile wipe-history --profile /nix/var/nix/profiles/system --older-than 7d
    sudo nix store gc --debug

# ------------------ Utilities ---------------------
age target:
    nix-shell -p ssh-to-age --run 'ssh-keyscan {{ target }} | ssh-to-age'

sops:
    sops updatekeys secrets/*.yaml

bootstrap:
    nix build .#image -L
    cp result/main.raw nixos-bootstrap
    xz nixos-bootstrap

# ---------------- Remote Servers ------------------
cache:
    ssh-add ~/.ssh/id_ed25519

deploy target: fmt cache
    nixos-rebuild switch --flake .#{{ target }} --build-host {{ target }} --target-host {{ target }} --fast --use-remote-sudo

aris target='aris': (deploy target)
astral target='astral': (deploy target)
rana target='rana': (deploy target)
