{ config, pkgs, osConfig, ... }:
{
  home.packages = with pkgs; [
    # https://github.com/flightlessmango/MangoHud
    # a simple overlay program for monitoring FPS, temperature, CPU and GPU load, and more.
    mangohud

    # GUI for installing custom Proton versions like GE_Proton
    # proton - a Wine distribution aimed at gaming
    protonplus

    # Script to install various redistributable runtime libraries in Wine.
    # winetricks

    # https://github.com/Open-Wine-Components/umu-launcher
    # a unified launcher for Windows games on Linux
    # umu-launcher
  ];

  # a GUI game launcher for Steam/GoG/Epic/Ubisoft
  # https://lutris.net/games?ordering=-popularity
  programs.lutris = {
    enable = true;
    # defaultWinePackage = pkgs.proton-ge-bin;
    steamPackage = osConfig.programs.steam.package;
    protonPackages = [ pkgs.proton-ge-bin ];
    winePackages = with pkgs; [
      wineWow64Packages.full
    ];
    extraPackages = with pkgs; [
      gamemode
      mangohud
      winetricks
      umu-launcher
      gamescope
    ];
  };
}