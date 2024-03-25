
rebuild:
  sh ./scripts/rebuild

build HOST:
  sh ./scripts/rebuild {{HOST}}

# Run as User
update-keys:
  nix-shell -p ssh-to-age --run "sudo ssh-to-age -private-key -i ~/.ssh/id_ed25519 | install -D -m 400 /dev/stdin ~/.config/sops/age/keys.txt"
