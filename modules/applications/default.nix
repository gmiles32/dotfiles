{ config, lib, pkgs, ... }: {
  imports = [
    ./vscode.nix
    ./syncthing.nix
    ./firefox.nix
    ./obsidian.nix
    ./discord.nix
    ./zotero.nix
    ./bitwarden.nix
    ./spotify.nix
    ./neovim.nix
    ./alacritty.nix
    ./localsend.nix
    ./quickemu.nix
    ./ticktick.nix
  ];
}
