{ config, lib, pkgs, inputs, ... }:
let
  cfg = config.desktop;
  mkSymlink = config.lib.file.mkOutOfStoreSymlink;
  confDir = "${config.home.homeDirectory}/nix-config/home/noctalia/conf";
in {
  imports = [
    inputs.noctalia.homeModules.default
  ];

  config = lib.mkIf (cfg.shell == "noctalia") {
    programs.noctalia.enable = true;

    xdg.configFile = {
      "noctalia".source = mkSymlink "${confDir}";
    };
  };
}