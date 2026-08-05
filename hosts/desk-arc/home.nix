{ config, pkgs, inputs, ... }:
let
  mkSymlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  imports = [
    ../../home/gui
    ../../home/terminal/kitty
    ../../users/ieu/home.nix
    ../../home/gaming.nix
    # ../../home/im/qq.nix
  ];

  gui = {
    enable = true;
    shell = "dms";
  };

  xdg.configFile."niri/niri-hardware.kdl".source = mkSymlink
    "${config.home.homeDirectory}/nix-config/hosts/desk-arc/niri-hardware.kdl";
}