{ config, pkgs, ... }:
let
  mkSymlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  home.packages = [ pkgs.nixpaks.firefox ];

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
    MOZ_WEBRENDER = "1";
  };

  xdg.configFile."mozilla/firefox/default/user.js".source = mkSymlink
    "${config.home.homeDirectory}/nix-config/home/browsers/user.js";
}
