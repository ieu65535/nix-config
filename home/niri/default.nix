{ config, ... }:
let
  mkSymlink = config.lib.file.mkOutOfStoreSymlink;
  confDir = "${config.home.homeDirectory}/nix-config/home/niri/conf";
in {
  xdg.configFile = {
    "niri/config.kdl".source = mkSymlink "${confDir}/config.kdl";
    "niri/binds.kdl".source = mkSymlink "${confDir}/binds.kdl";
    "niri/layout.kdl".source = mkSymlink "${confDir}/layout.kdl";
    "niri/output.kdl".source = mkSymlink "${confDir}/output.kdl";
  };
}
