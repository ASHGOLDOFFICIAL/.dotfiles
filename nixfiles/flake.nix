{
  description = "A NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.6.0";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    home-manager,
    nixpkgs,
    ...
  }@inputs:

  let 
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in {
    nixosConfigurations = {
      aurum = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          inputs.nix-flatpak.nixosModules.nix-flatpak
          ./hosts/asus-laptop/configuration.nix
        ];
      };
      
      ferrum = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          inputs.nix-flatpak.nixosModules.nix-flatpak
          ./hosts/desktop/configuration.nix
        ];
      };
    };

    homeConfigurations = {
      ashgoldofficial = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home-manager/home.nix
        ];
      };
    };
  };
}
