{ pkgs, config, lib, ... }:
{
  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrains Maple Mono";
      size = 14;
    };
    settings = {
      window_padding_width = 12;
      hide_window_decorations = "yes";
      background_opacity = "0.8";
      background_blur = 32;
      confirm_os_window_close = 0;
      shell = "${pkgs.fish}/bin/fish";
      cursor_shape = "block";
      cursor_blink_interval = 1;
      shell_integration = "enabled";
      scrollback_lines = 3000;
      copy_on_select = "yes";
      strip_trailing_spaces = "smart";
      tab_bar_style = "powerline";
      tab_bar_align = "left";
      # 快捷键映射
      "map ctrl+shift+n" = "new_window";
      "map ctrl+t" = "new_tab";
      "map ctrl+plus" = "change_font_size all +1.0";
      "map ctrl+minus" = "change_font_size all -1.0";
      "map ctrl+0" = "change_font_size all 0";
    };
    extraConfig = ''
      include dank-tabs.conf
      include dank-theme.conf
    '';
  };
}
