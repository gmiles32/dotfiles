{ config, lib, pkgs, ... }: {
  imports = [
    ./vscodium.nix
    ./syncthing.nix
    ./firefox.nix
    ./obsidian.nix
    ./discord.nix
    ./zotero.nix
    ./bitwarden.nix
    ./spotify.nix
    ./neovim.nix
    ./alacritty.nix
  ];
}
