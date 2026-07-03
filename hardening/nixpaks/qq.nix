{
  lib,
  qq,
  mkNixPak,
  buildEnv,
  makeDesktopItem,
  ...
}:
let
  appId = "com.qq.QQ";
  wrapped = mkNixPak {
    config = { sloth, ... }: {
      app = {
        package = qq;
        binPath = "bin/qq";
      };
      flatpak.appId = appId;

      imports = [
        ./modules/gui-base.nix
        ./modules/network.nix
        ./modules/common.nix
      ];

      bubblewrap = {
        bind.rw = [
          sloth.xdgDocumentsDir
          sloth.xdgDownloadDir
          sloth.xdgMusicDir
          sloth.xdgVideosDir
          sloth.xdgPicturesDir
        ];
        sockets = {
          x11 = false;
          wayland = true;
          pipewire = true;
        };
      };
    };
  };
  exePath = lib.getExe wrapped.config.script;
in
buildEnv {
  inherit (wrapped.config.script) name meta passthru;
  paths = [
    wrapped.config.script
    (makeDesktopItem {
      name = appId;
      desktopName = "QQ";
      genericName = "QQ Boxed";
      comment = "Tencent QQ";
      exec = "${exePath} %U";
      terminal = false;
      icon = "${qq}/share/icons/hicolor/512x512/apps/qq.png";
      startupNotify = true;
      startupWMClass = "QQ";
      type = "Application";
      categories = [ "InstantMessaging" "Network" ];
      extraConfig.X-Flatpak = appId;
    })
  ];
}
