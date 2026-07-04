{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    # Niri v25.08 will create X11 sockets on disk, export $DISPLAY, and spawn `xwayland-satellite` on-demand when an X11 client connects
    xwayland-satellite

    # for Screenshot Annotation
    # slurp
    # grim
    # satty
  ];

  xdg.configFile = 
    let
      mkSymlink = config.lib.file.mkOutOfStoreSymlink;
      confDir = "${config.home.homeDirectory}/nix-config/home/niri/conf";
    in 
    {
      "niri/config.kdl".source = mkSymlink "${confDir}/config.kdl";
      "niri/binds.kdl".source = mkSymlink "${confDir}/binds.kdl";
      "niri/layout.kdl".source = mkSymlink "${confDir}/layout.kdl";
      "niri/input.kdl".source = mkSymlink "${confDir}/input.kdl";
      "niri/startup.kdl".source = mkSymlink "${confDir}/startup.kdl";
      "niri/windowrules.kdl".source = mkSymlink "${confDir}/windowrules.kdl";
      "niri/noctalia.kdl".source = mkSymlink "${confDir}/noctalia.kdl";
    };
}
