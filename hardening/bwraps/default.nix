{
  nixpkgs.overlays = [
    (final: super: {
      bwraps = {
        wechat = super.callPackage ./wechat.nix { };
      };
    })
  ];
}
