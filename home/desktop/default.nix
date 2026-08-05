{ config, lib, pkgs, inputs, ... }:

let
  cfg = config.desktop;
  shellType = lib.types.enum [ "noctalia" "dms" ];
in
{
  imports = [
    ../noctalia
    ../niri
    ./dms.nix
  ];
  
  options.desktop = {
    enable = lib.mkEnableOption "desktop";
    shell = lib.mkOption {
      type = shellType;
      default = "noctalia";
      description = "Desktop shell to use (noctalia or dms)";
    };
  };

  config = {

  };
}