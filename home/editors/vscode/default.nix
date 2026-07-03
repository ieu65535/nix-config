{ config, pkgs, ... }:
let
  mkSymlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;

    profiles.default.extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
    ];
  };

  xdg.configFile."Code/User/settings.json".source = mkSymlink
    "${config.home.homeDirectory}/nix-config/home/editors/vscode/settings.json";
}
