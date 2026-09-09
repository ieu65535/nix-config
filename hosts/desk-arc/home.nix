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
    ../../home/fcitx5
    ../../home/im/qq.nix
    ../../home/browsers/firefox.nix
    ../../home/browsers/chrome.nix
    ../../home/editors/vscode
    ../../home/editors/zed.nix
    ../../home/editors/nvim
  ];

  home.packages = with pkgs; [
    nixd
  ];

  gui = {
    enable = true;
    shell = "dms";
  };

  programs = {
    opencode.enable = true;

    fish.enable = true;

    devenv = {
      enable = true;
      enableFishIntegration = true;
    };

    nix-index = {
      enable = true;
      enableFishIntegration = true;
    };
  };

  xdg.configFile."niri/niri-hardware.kdl".source = mkSymlink
    "${config.home.homeDirectory}/nix-config/hosts/desk-arc/niri-hardware.kdl";
}
