{
  imports = [
    ../../users/ieu/home.nix
    ../../home/editors/nvim
  ];

  programs = {
    opencode.enable = true;

    fish.enable = true;

    devenv = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}
