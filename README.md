# How to configure
1) First, edit configuration.nix for machine to allow for git and openssh.
2) Clone the github repository, and then copy the saved `sops` and `ssh` directory from backup drive to the home directory of the user.
3) Rebuild system.
5) To configure fish theme, run `tide configure` and go through the prompts.

# Templates
To create a project from a template:
```fish
nix flake init -t github:gmiles32/dotfiles#mytemplate
```
