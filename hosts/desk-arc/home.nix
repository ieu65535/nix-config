{ config, pkgs, inputs, ... }:
let
  mkSymlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  imports = [
    ../../home/desktop
    ../../users/ieu/home.nix
    ../../home/gaming.nix
    # ../../home/im/qq.nix
  ];

  desktop.shell = "noctalia"; # Change to "dms" to switch to DankMaterialShell

  xdg.configFile."niri/niri-hardware.kdl".source = mkSymlink
    "${config.home.homeDirectory}/nix-config/hosts/desk-arc/niri-hardware.kdl";
}