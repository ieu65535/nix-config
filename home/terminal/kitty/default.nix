{ pkgs, config, lib, ... }:
let
  cfg = config.gui;
  mkSymlink = config.lib.file.mkOutOfStoreSymlink;
  confDir = "${config.home.homeDirectory}/nix-config/home/terminal/kitty/conf";
in 
{
  programs.kitty = {
    enable = true;
    font = lib.mkIf (cfg.shell == "noctalia") {
      name = "JetBrains Maple Mono";
      size = 13.5;
    };
    settings = lib.mkIf (cfg.shell == "noctalia") {
      window_padding_width = 5;
      hide_window_decorations = "yes";
      background_opacity = "0.8";
      confirm_os_window_close = 0;
      shell = "${pkgs.fish}/bin/fish";
      cursor_shape = "block";
      cursor_trail = 1;
      shell_integration = "no-cursor";
    };
  };
  xdg.configFile = lib.mkIf (cfg.shell == "dms") {
    "kitty".source = mkSymlink "${confDir}";
  };
}
