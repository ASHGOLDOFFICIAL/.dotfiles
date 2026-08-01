# All desktop environment modules
{ ... }:

{
  imports = [
    ./gnome.nix
    ./hyprland.nix
    ./plasma.nix
  ];
}
