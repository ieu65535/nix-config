{ config, pkgs, ... }:
let
  mkSymlink = config.lib.file.mkOutOfStoreSymlink;
  src = "${config.home.homeDirectory}/nix-config/home/fcitx5";
in
{
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.waylandFrontend = true;
    fcitx5.addons = with pkgs; [
      qt6Packages.fcitx5-configtool # GUI for fcitx5
      fcitx5-gtk # gtk im module

      # Chinese
      fcitx5-rime # for flypy chinese input method
      # fcitx5-chinese-addons # we use rime instead

      # Japanese
      # ctrl-i / F7 - convert to takakana
      # ctrl-u / F6 - convert to hiragana
      # fcitx5-mozc-ut # Moze with UT dictionary

      # Korean
      # fcitx5-hangul
    ];
  };

  xdg.configFile = {
    "fcitx5/profile".source = mkSymlink "${src}/profile";
    "fcitx5/config".source = mkSymlink "${src}/config";
  };
}
