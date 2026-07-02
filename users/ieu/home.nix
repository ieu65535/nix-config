{ config, pkgs, inputs, ... }:
{
  imports = [ inputs.noctalia.homeModules.default ];

  home.stateVersion = "26.05";
  programs = {
    git = {
      enable = true;
      settings = {
        user = {
          name = "ieu";
          email = "3384953140@qq.com";
        };
        init.defaultBranch = "main";
      };
    };
    opencode.enable = true;
    noctalia.enable = true;
  };
}
