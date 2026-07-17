{ inputs, pkgs, ... }:
{
  imports = [
    ./configuration.nix
    ../../modules/security.nix
    ../../modules/hardware-intel.nix
    ../../modules/gaming.nix
    ../../modules/virtualisation.nix
    ../../modules/i18n.nix
    ../../modules/clash.nix
    ../../modules/btrfs.nix
  ];

  boot.loader.systemd-boot.configurationLimit = 10;

  # do garbage collection weekly to keep disk usage low
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # Optimise storage
  # you can also optimise the store manually via:
  #    nix-store --optimise
  # https://nixos.org/manual/nix/stable/command-ref/conf-file.html#conf-auto-optimise-store
  nix.settings.auto-optimise-store = true;

  nixpkgs.config.allowUnfree = true;

  services.displayManager = {
    defaultSession = "niri";
    sddm = {
      enable = true;
      wayland.enable = true;
    };
    autoLogin = {
      enable = true;
      user = "ieu";
    };
  };

  services = {
    gvfs.enable = true; # Mount, trash, and other functionalities
    tumbler.enable = true; # Thumbnail support for images
  };

  programs = {
    # dconf is a low-level configuration system.
    dconf.enable = true;

    # thunar file manager(part of xfce) related options
    thunar = {
      enable = true;
      plugins = with pkgs; [
        thunar-archive-plugin
        thunar-volman
      ];
    };
  };

  hardware.bluetooth.enable = true;
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;
  
  environment.systemPackages = [ 
    pkgs.nautilus
    pkgs.mission-center
    pkgs.fastfetch
  ];

  fonts.enableDefaultPackages = true;

  fonts.packages = with pkgs; [
    wqy_zenhei
    wqy_microhei
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
  ];
  
  zramSwap.enable = true; # Creates a zram block device and uses it as a swap device

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    useUserPackages = true;
    users.ieu = import ./home.nix;
  };
}