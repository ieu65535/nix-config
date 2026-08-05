{ config, pkgs, lib, ... }:

let
  cfg = config.gui;
  mkSymlink = config.lib.file.mkOutOfStoreSymlink;
  confDir = "${config.home.homeDirectory}/nix-config/home/niri/conf";
in
{
  imports = [
    ./fuzzel.nix
  ];

  xdg.configFile = {
    "niri/config.kdl".source = mkSymlink (
      if cfg.shell == "noctalia" 
      then "${confDir}/noctalia-config.kdl" 
      else "${confDir}/dms-config.kdl"
    );

    "niri/layout.kdl".source = mkSymlink "${confDir}/layout.kdl";
    "niri/input.kdl".source = mkSymlink "${confDir}/input.kdl";
    "niri/windowrules.kdl".source = mkSymlink "${confDir}/windowrules.kdl";

    "niri/scripts/niri-pick".source = mkSymlink "${confDir}/scripts/niri-pick";
    
    # Only include noctalia.kdl when using noctalia
    "niri/noctalia.kdl" = lib.mkIf (cfg.shell == "noctalia") {
      source = mkSymlink "${confDir}/noctalia.kdl";
    };
    "niri/binds.kdl" = lib.mkIf (cfg.shell == "noctalia") {
      source = mkSymlink "${confDir}/binds.kdl";
    };
    "niri/startup.kdl" = lib.mkIf (cfg.shell == "noctalia") {
      source = mkSymlink "${confDir}/startup.kdl";
    };

    "niri/dms" = lib.mkIf (cfg.shell == "dms") {
      source = mkSymlink "${confDir}/dms";
    };
  };
}