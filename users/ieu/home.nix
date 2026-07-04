{ config, pkgs, inputs, ... }:
{
  imports = [
    inputs.noctalia.homeModules.default
    ../../home/niri
    ../../home/terminal/kitty.nix
    ../../home/editors/vscode
    ../../home/browsers/chrome.nix
    ../../home/fcitx5
    # ../../home/browsers/firefox.nix
    # ../../home/im/qq.nix
    # ../../home/im/wechat.nix
    # ../../home/niri/fuzzel.nix
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

  };
}
