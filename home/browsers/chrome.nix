{ pkgs, ... }:
{
  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  programs.google-chrome = {
    enable = true;
    package = pkgs.google-chrome;
  };
}
