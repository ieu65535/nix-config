{ config, lib, pkgs, inputs, ... }:

let
  cfg = config.gui;
  shellType = lib.types.enum [ "noctalia" "dms" ];
in
{
  imports = [
    ./noctalia
    ./niri
    inputs.noctalia.homeModules.default
    inputs.dms.homeModules.dank-material-shell
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
    home.packages = with pkgs; [
      # Niri v25.08 will create X11 sockets on disk, export $DISPLAY, and spawn `xwayland-satellite` on-demand when an X11 client connects
      xwayland-satellite

      # for Screenshot Annotation
      # slurp
      # grim
      # satty

      wl-clipboard
    ];

    programs.dank-material-shell = lib.mkIf (cfg.shell == "dms") {
      enable = true;
      package = pkgs.dms-shell;
    };

    programs.noctalia.enable = lib.mkIf (cfg.shell == "noctalia") true;

  };
}