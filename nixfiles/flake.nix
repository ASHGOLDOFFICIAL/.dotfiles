{
  description = "A NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.6.0";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = {
    self,
    home-manager,
    nixpkgs,
    nixpkgs-stable,
    nixpkgs-unstable,
    ...
  }@inputs:

  let 
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
    pkgsStable = import nixpkgs-stable { inherit system; };
    pkgsUnstable = import nixpkgs-unstable { inherit system; };
  in {
    nixosConfigurations = {
      aurum = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          inputs.nix-flatpak.nixosModules.nix-flatpak
          ./hosts/asus-laptop/configuration.nix
        ];
        specialArgs = { inherit pkgsStable; inherit pkgsUnstable; };
      };
      
      ferrum = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          inputs.nix-flatpak.nixosModules.nix-flatpak
          ./hosts/desktop/configuration.nix
        ];
        specialArgs = { inherit pkgsStable; inherit pkgsUnstable; };
      };
    };

    homeConfigurations = {
      ashgoldofficial = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          inputs.plasma-manager.homeManagerModules.plasma-manager
          ./home-manager/home.nix
        ];
      };
    };
  };
}
