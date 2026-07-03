{ pkgs, ... }:
{
  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrains Maple Mono";
      size = 13.5;
    };
    settings = {
      window_padding_width = 5;
      hide_window_decorations = "yes";
      background_opacity = "0.8";
      confirm_os_window_close = 0;
      shell = "${pkgs.fish}/bin/fish";
      cursor_shape = "block";
      cursor_trail = 1;
      shell_integration = "no-cursor";

      foreground = "#e5e1e6";
      background = "#131316";
      selection_foreground = "#c7c5d0";
      selection_background = "#46464f";
      active_border_color = "#bec2ff";
      inactive_border_color = "#46464f";
      url_color = "#bec2ff";
      color0 = "#131316";
      color1 = "#ffb4ab";
      color2 = "#bec2ff";
      color3 = "#c5c4dd";
      color4 = "#e7b9d5";
      color5 = "#bec2ff";
      color6 = "#c5c4dd";
      color7 = "#e5e1e6";
      color8 = "#91909a";
      color9 = "#ffb4ab";
      color10 = "#bec2ff";
      color11 = "#c5c4dd";
      color12 = "#e7b9d5";
      color13 = "#bec2ff";
      color14 = "#c5c4dd";
      color15 = "#e5e1e6";
      cursor = "#e5e1e6";
      cursor_text_color = "#131316";
      active_tab_foreground = "#1f2578";
      active_tab_background = "#bec2ff";
      inactive_tab_foreground = "#c7c5d0";
      inactive_tab_background = "#46464f";
    };
  };
}
