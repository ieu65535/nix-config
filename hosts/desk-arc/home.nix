{ config, pkgs, ... }:
let
  mkSymlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  imports = [
    ../../home/gui
    ../../home/terminal/kitty
    ../../users/ieu/home.nix
    ../../home/gaming.nix
    ../../home/im/qq.nix
    ../../home/browsers/firefox.nix
    ../../home/browsers/chrome.nix
    ../../home/editors/vscode
    ../../home/editors/zed.nix
  ];

  home.packages = with pkgs; [
    nixd
    nil
  ];

  gui = {
    enable = true;
    shell = "dms";
  };

  xdg.configFile."niri/niri-hardware.kdl".source = mkSymlink
    "${config.home.homeDirectory}/nix-config/hosts/desk-arc/niri-hardware.kdl";
}
