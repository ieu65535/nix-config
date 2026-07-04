{
  config,
  pkgs,
  ...
}:
{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;  # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports for Source Dedicated Server hosting
    # Other general flags if available can be set here.

    # https://github.com/ValveSoftware/gamescope
    # Run a GameScope driven Steam session from your display-manager
    # fix resolution upscaling and stretched aspect ratios
    gamescopeSession.enable = true;
    # https://github.com/Winetricks/winetricks
    # Whether to enable protontricks, a simple wrapper for running Winetricks commands for Proton-enabled games.
    # protontricks.enable = true;
    # Whether to enable Load the extest library into Steam, to translate X11 input events to uinput events (e.g. for using Steam Input on Wayland) .
    # extest.enable = true;
    fontPackages = [
      pkgs.wqy_zenhei # Need by steam for Chinese
    ];
  };

  # see https://github.com/fufexan/nix-gaming/#pipewire-low-latency
  services.pipewire.lowLatency.enable = true;
  programs.steam.platformOptimizations.enable = true;

  # Optimise Linux system performance on demand
  # https://github.com/FeralInteractive/GameMode
  # https://wiki.archlinux.org/title/Gamemode
  #
  # Usage:
  #   1. For games/launchers which integrate GameMode support:
  #      https://github.com/FeralInteractive/GameMode#apps-with-gamemode-integration
  #      simply running the game will automatically activate GameMode.
  programs.gamemode.enable = true;
}