{
  imports = [
    ../../users/ieu/home.nix
  ];

  programs = {
    opencode.enable = true;

    fish.enable = true;
  };
}
