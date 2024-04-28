{ pkgs, ... }:
  let
    callPackage = pkgs.callPackage;
  in {
    nixpkgs.overlays = [(final: prev: {
      npm = {
        quartz = callPackage ./quartz.nix {};
      };
    })];
  }
