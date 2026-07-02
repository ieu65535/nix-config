{ config, pkgs, ... }:
{
  home.stateVersion = "26.05";
  programs.git = {
    enable = true;
    settings = {
      user = {
        userName = "ieu";
        userEmail = "3384953140@qq.com";
      };
      init.defaultBranch = "main";
    };
  };
}
