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

    noctalia.enable = true;

    fish.enable = true;

    fuzzel = {
      enable = true;
      settings = {
        main = {
          terminal = "kitty -e";
          font = "adwaita sans:size=13";
          lines = 9;
          width = 35;
          horizontal-pad = 40;
          vertical-pad = 15;
          inner-pad = 5;
          line-height = 25;
        };
        border = {
          width = 2;
          radius = 10;
        };
        colors = {
          background = "131316CC";
          text = "e5e1e6ff";
          prompt = "c5c4ddff";
          placeholder = "e7b9d5ff";
          input = "bec2ffff";
          match = "e7b9d5ff";
          selection = "bec2ff80";
          selection-text = "e5e1e6ff";
          selection-match = "1f2578ff";
          counter = "c5c4ddff";
          border = "bec2ffff";
        };
      };
    };
  };
}
