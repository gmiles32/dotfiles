{ pkgs, ... }: 
  let
    callPackage = pkgs.callPackage;
  in {
    nixpkgs.overlays = [(final: prev: {
      themes = {
        whitesur-gtk-theme = callPackage ./whitesur-gtk.nix {};
      };
    })];
  }
