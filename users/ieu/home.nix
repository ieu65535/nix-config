{ config, pkgs, inputs, ... }:
{
  imports = [
    ../../home/editors/vscode
    ../../home/browsers/chrome.nix
    ../../home/fcitx5
    # ../../home/browsers/firefox.nix
    # ../../home/im/qq.nix
    # ../../home/im/wechat.nix
  ];

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

    fish.enable = true;

    devenv = {
      enable = true;
      enableFishIntegration = true;
    };

  };
}
