{
  programs.zed-editor = {
    enable = true;
    extensions = [ "nix" "toml" "rust" ];
    userSettings = {
      theme = {
        mode = "system";
        dark = "One Dark";
        light = "One Light";
      };
      auto_update = false;
      vim_mode = true;
      vim = {
        toggle_relative_line_numbers = true;
      };
    };
  };
}