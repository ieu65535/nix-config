{ config, pkgs, inputs, ... }:
let
  mkSymlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  imports = [
    ../../users/ieu/home.nix
    ../../home/noctalia
    ../../home/gaming.nix
  ];

  xdg.configFile."niri/niri-hardware.kdl".source = mkSymlink
    "${config.home.homeDirectory}/nix-config/hosts/desk-arc/niri-hardware.kdl";
}