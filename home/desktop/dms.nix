{ config, lib, pkgs, inputs, ... }:

let
  cfg = config.desktop;
in
{
  imports = [
    inputs.dms.homeModules.dank-material-shell
    # inputs.dms.homeModules.niri
  ];

  config = lib.mkIf (cfg.shell == "dms") {
    programs.dank-material-shell = {
      enable = true;
      # niri = {
      #   enableKeybinds = true;
      #   enableSpawn = true;
      # };
    };
  };
}