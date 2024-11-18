{
  description = "A NixOS configuration";

  inputs = {
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/4aa36568d413aca0ea84a1684d2d46f55dbabad7";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  let 
    system = "x86_64-linux";
  in {
    nixosConfigurations = {
      
      aurum = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [ ./hosts/asus-laptop/configuration.nix ];
      };
      
      ferrum = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [ ./hosts/desktop/configuration.nix ];
      };

    };

    homeConfigurations = {
      ashgoldofficial = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [ ./home-manager/home.nix ];
      };
    };
  };
}
