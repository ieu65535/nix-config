{ config, lib, pkgs, inputs, ... }:

let
  cfg = config.gui;
  shellType = lib.types.enum [ "noctalia" "dms" ];
in
{
  imports = [
    ./display-manager.nix
    inputs.noctalia.nixosModules.default
  ];
  
  options.gui = {
    enable = lib.mkEnableOption "gui";
    shell = lib.mkOption {
      type = shellType;
      default = "noctalia";
      description = "Desktop shell to use (noctalia or dms)";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # Niri v25.08 will create X11 sockets on disk, export $DISPLAY, and spawn `xwayland-satellite` on-demand when an X11 client connects
      xwayland-satellite

      # for Screenshot Annotation
      # slurp
      # grim
      # satty

      wl-clipboard
    ];

    programs.dms-shell = lib.mkIf (cfg.shell == "dms") {
      enable = true;
    };

    programs.noctalia = lib.mkIf (cfg.shell == "noctalia") {
      enable = true;

      # Enables NetworkManager, Bluetooth, UPower, and a power profile service.
      recommendedServices.enable = true;
    };
  };
}