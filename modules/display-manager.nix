{ config, pkgs, lib, inputs, ... }:

let
  cfg = config.display-manager;
  greeterType = lib.types.enum [ "dms-greeter" "noctalia-greeter" "sddm" ];
in
{
  imports = [
    inputs.noctalia-greeter.nixosModules.default
  ];

  options.display-manager = {
    enable = lib.mkEnableOption "display manager (login greeter)";
    greeter = lib.mkOption {
      type = greeterType;
      default = "noctalia-greeter";
      description = "Login greeter to use: dms-greeter, noctalia-greeter, or sddm";
    };
  };

  config = lib.mkIf cfg.enable {
    services.displayManager = {
      defaultSession = "niri";
      sddm = lib.mkIf (cfg.greeter == "sddm") {
        enable = true;
        wayland.enable = true;
      };
      autoLogin = lib.mkIf (cfg.greeter == "sddm") {
        enable = true;
        user = "ieu";
      };
    };

    programs.noctalia-greeter = lib.mkIf (cfg.greeter == "noctalia-greeter") {
      enable = true;
      greeter-args = "--session niri";
      settings = {
        session.default = "niri";
        user.default = "ieu";
        outputs.name = "DP-3";
      };
    };

    services.displayManager.dms-greeter = lib.mkIf (cfg.greeter == "dms-greeter") {
      enable = true;
      compositor.name = "niri";
      configHome = "/home/ieu";
    };

    security.pam.services.greetd.enableGnomeKeyring = lib.mkIf (cfg.greeter != "sddm") true;
    security.pam.services.sddm.enableGnomeKeyring = lib.mkIf (cfg.greeter == "sddm") true;
  };
}
