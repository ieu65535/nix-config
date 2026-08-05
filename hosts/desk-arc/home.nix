{ config, pkgs, inputs, ... }:
let
  mkSymlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  imports = [
    ../../home/desktop
    ../../home/terminal/kitty
    ../../users/ieu/home.nix
    ../../home/gaming.nix
    # ../../home/im/qq.nix
  ];

  gui = {
    enable = true;
    shell = "noctalia";
  };

  xdg.configFile."niri/niri-hardware.kdl".source = mkSymlink
    "${config.home.homeDirectory}/nix-config/hosts/desk-arc/niri-hardware.kdl";
}