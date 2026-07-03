{ config, lib, pkgs, inputs, ... }:
let
  nixpak = inputs.nixpak;
  mkNixPak = nixpak.lib.nixpak {
    inherit (pkgs) lib;
    inherit pkgs;
  };
  callArgs = { inherit mkNixPak; };
in
{
  nixpkgs.overlays = [
    (final: super: {
      nixpaks = {
        firefox = super.callPackage ./firefox.nix callArgs;
        qq = super.callPackage ./qq.nix callArgs;
      };
    })
  ];
}
