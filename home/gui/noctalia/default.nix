{ config, lib, pkgs, inputs, ... }:
let
  cfg = config.gui;
  mkSymlink = config.lib.file.mkOutOfStoreSymlink;
  confDir = "${config.home.homeDirectory}/nix-config/home/gui/noctalia/conf";
in {
  config = lib.mkIf (cfg.shell == "noctalia") {
    xdg.configFile = {
      "noctalia".source = mkSymlink "${confDir}";
    };
  };
}