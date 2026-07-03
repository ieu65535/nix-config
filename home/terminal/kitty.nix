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
    };
  };
}
