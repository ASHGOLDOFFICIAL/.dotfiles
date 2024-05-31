{
  description = "A NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, aagl, ... }@inputs:
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
        modules = [
          ./hosts/desktop/configuration.nix
          {
            imports = [ aagl.nixosModules.default ];
            nix.settings = aagl.nixConfig;
            programs.anime-game-launcher.enable = true;
          }
        ];
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
