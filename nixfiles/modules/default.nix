# All custom modules
{ ... }:

{
  imports = [
    ./cli
    ./gui
    ./hardware
    ./server
    ./iwd.nix
  ];
}
