# All custom modules
{ ... }:

{
  imports = [
    ./emulators.nix
    ./firefox.nix
    ./gaming.nix
    ./gnome.nix
    ./iwd.nix
    ./nvidia.nix
    ./plasma.nix
  ];
}
