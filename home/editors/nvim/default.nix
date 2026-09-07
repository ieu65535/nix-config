{ pkgs, config, ...}:
let
  mkSymlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  programs.neovim = {
    enable = true;
    extraPackages = with pkgs; [
      nil
      nixd
      lua-language-server
    ];
    plugins = with pkgs.vimPlugins; [
      lazy-nvim
      tokyonight-nvim
      bufferline-nvim
      nvim-web-devicons
      nvim-autopairs
      nvim-surround
      nvim-lspconfig
    ];
    initLua = 
      # lua
      ''
        require("core.basic")
        require("core.keymap")
        require("lazy").setup({
          defaults = { lazy = true },
          rocks = { enabled = false },
          pkg = { enabled = false },
          install = { missing = false },
          dev = {
            path = "~/.local/share/nvim/site/pack/hm/start",
            patterns = { "" },
          },
          spec = {
            { import = "plugins" }
          },
        })
    '';
  };

  xdg.configFile."nvim/lua".source = mkSymlink
    "${config.home.homeDirectory}/nix-config/home/editors/nvim/conf";
}
