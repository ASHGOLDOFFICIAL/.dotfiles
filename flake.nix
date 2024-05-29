{
  description = "A NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations = {
      aurum = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./hosts/asus-laptop/configuration.nix ];
      };
      ferrum = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./hosts/desktop/configuration.nix ];
      };
    };
  };
}
