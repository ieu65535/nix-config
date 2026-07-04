{ config, pkgs, ... }:
let
  mkSymlink = config.lib.file.mkOutOfStoreSymlink;
  confDir = "${config.home.homeDirectory}/nix-config/home/noctalia/conf";
in {
  programs.noctalia.enable = true;

  xdg.configFile = {
    "noctalia".source = mkSymlink "${confDir}";
  };
}