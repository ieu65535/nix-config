{ pkgs, lib, ... }:
let
  xilinx-fhs = pkgs.buildFHSEnv {
    name = "xilinx";
    targetPkgs = pkgs: with pkgs; [
      # === vivado ===
      # === X11 图形库 ===
      libx11            # libX11-xcb.so.1
      libxext
      libxi
      libxrender
      libxtst
      # === 字体与渲染 ===
      freetype          # libfreetype.so.6
      fontconfig        # libfontconfig.so.1

      # === 其他系统库 ===
      zlib
      util-linux        # libuuid.so.1
      ncurses
      ncurses5
      pixman
      libpng

      # === vitis ===
      # stdenv.cc.cc.lib
      # libgcc

      # libxcursor        # libXcursor.so.1
      # libxft            # libXft.so.2
      # libxshmfence      # libxshmfence.so.1
      # libxxf86vm        # libXxf86vm.so.1
      # libxcomposite
      # libxdamage
      # libxfixes
      # libxrandr
      # libxcb
      # libxkbcommon

      # glib
      # gtk2            # libgdk-x11-2.0.so.0 libgtk-x11-2.0.so.0
      # gtk3            # libgdk-3.so.0 libgtk-3.so.0
      # libsecret       # libsecret-1.so.0
      # libxml2
      # nspr
      # atk
      # # The following are required but presumably satisfied indirectly:
      # at-spi2-core    # libatk-1.0.so.0 libatk-bridge-2.0.so.0 libatspi.so.0
      # cairo           # libcairo-gobject.so.2 libcairo.so.2
      # gdk-pixbuf      # libgdk_pixbuf-2.0.so.0
      # libglvnd        # (via gtk3) libEGL.so.1 libGL.so.1
      # libpcap         # libpcap.so.1
      # libpfm          # libpfm.so.4
      # pango           # libpango-1.0.so.0 libpangocairo-1.0.so.0 libpangoft2-1.0.so.0
      # # Required by some installed (but possibly unused) binaries:
      # alsa-lib        # libasound.so.2
      # ffmpeg_4        # libavcodec.so.58 libavformat.so.58
      # libxkbfile      # libxkbfile.so.1
      # libgbm
      # cups
      # libdrm
      # expat
      # dbus            # for Vitis xsct if Xvfb is used
      # graphviz        # AIE tools
      # libselinux      # libselinux.so.1
      # nss             # for Vitis tools
      # openssl         # AIE tools

      # gcc
      # git
      # inetutils
      # unzip
      # zip
    ];
    runScript = "bash";
    profile = ''
      export _JAVA_AWT_WM_NONREPARENTING=1
      export LD_LIBRARY_PATH=/usr/lib64:$LD_LIBRARY_PATH

      # 关键：禁用 GPU 沙箱（解决常见崩溃）
      # export ELECTRON_ENABLE_SANDBOX=false
      # 设置证书路径（指向 NixOS 的系统证书）
      # export NSS_SSL_CERTIFICATE_DIR=/etc/ssl/certs
      # export SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt
      # 强制使用 X11 后端（避免 Wayland 兼容问题）
      # export GDK_BACKEND=x11
      # export QT_QPA_PLATFORM=xcb
      # 为 DBus 设置地址（如果环境中有，默认会继承）
      # 若没有，尝试使用 unix:path=/run/user/$UID/bus
      # export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$UID/bus"
      # === 新增：强制软件渲染 ===
      # export MESA_LOADER_DRIVER_OVERRIDE=swrast
      # export LIBGL_ALWAYS_SOFTWARE=1
      # export GALLIUM_DRIVER=llvmpipe
      # 防止 X11 连接错误
      # export DISPLAY=:0
      # export EGL_PLATFORM=surfaceless   # 额外避免 EGL 调用 DRM
      # export GBM_BACKEND=null           # 禁用 GBM 后端
    '';
  };
in
{
  environment.systemPackages = with pkgs; [
    xilinx-fhs
  ];
}