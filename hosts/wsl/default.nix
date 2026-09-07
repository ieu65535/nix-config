{ config, inputs, lib, pkgs, ... }:

{
  imports = [
    ../../modules/gc.nix
  ];

  wsl.enable = true;
  wsl.defaultUser = "ieu";

  nix.settings = {
    substituters = [
      "https://mirror.sjtu.edu.cn/nix-channels/store?priority=10"
      "https://mirrors.ustc.edu.cn/nix-channels/store?priority=5"
      "https://cache.nixos.org/"
    ];
    experimental-features = [ "nix-command" "flakes" ];
  };

  environment.systemPackages = with pkgs; [
    vim
    git
    wget
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    useUserPackages = true;
    users.ieu = import ./home.nix;
  };

  # boot.binfmt = {
  #   emulatedSystems = [ "aarch64-linux" ];
  #   preferStaticEmulators = true; # required to work with podman
  # };

  virtualisation = {
    podman = {
      enable = true;
      # Periodically prune Podman resources
      autoPrune = {
        enable = true;
        dates = "weekly";
        flags = [ "--all" ];
      };
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?
}
