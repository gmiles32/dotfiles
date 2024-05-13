{
  description = "My NixOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence.url = "github:Nix-community/impermanence";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows ="nixpkgs";
    };

    wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    oh-my-bash = {
      url = "github:ohmybash/oh-my-bash";
      inputs.nixpkgs.follows = "nixpkgs";
    }; 
  };


  outputs = { nixpkgs, ... }@inputs:
    let
      
      globals = let
      in rec {
        user = "gabe";
        fullName = "Gabe Miles";
        gitName = fullName;
        gitEmail = "gabrielmiles32@gmail.com";
      };

      system = "x86_64-linux";

    in rec {
      nixosConfigurations = {
        seneca = import ./hosts/seneca { inherit inputs globals system; };
        wsl = import ./hosts/wsl { inherit inputs globals system; };
      };
    };
}
