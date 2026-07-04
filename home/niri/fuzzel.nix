{ config, pkgs, ... }:
{
  programs.fuzzel = {
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
}
