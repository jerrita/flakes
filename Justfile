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

# ---------------- Remote Servers ------------------
cache:
    ssh-add ~/.ssh/id_ed25519

deploy target: fmt cache
    nixos-rebuild switch --flake .#{{ target }} --target-host {{ target }} --build-host {{ target }} --fast --use-remote-sudo

astral target='astral': (deploy target)
