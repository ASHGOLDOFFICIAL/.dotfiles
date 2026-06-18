# All custom modules
{ ... }:

{
  imports = [
    ./emulators.nix
    ./firefox.nix
    ./gaming.nix
    ./gnome.nix
    ./hyprland.nix
    ./iwd.nix
    ./media.nix
    ./nvidia.nix
    ./plasma.nix
  ];
}
