{ pkgs, config, lib, ...}:
let
  mkSymlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  programs.neovim = {
    enable = true;
    extraPackages = with pkgs; [
      nil
      nixd
      ripgrep
      lua-language-server
    ];
    plugins = with pkgs.vimPlugins; [
      lazy-nvim
    ];

    initLua =
      let
        treesitter = pkgs.vimPlugins.nvim-treesitter.withAllGrammars;

        treesitterGrammars = pkgs.symlinkJoin {
          name = "nvim-treesitter-grammars";
          paths = treesitter.dependencies;
        };

        plugins = with pkgs.vimPlugins; [
          blink-cmp
          bufferline-nvim
          conform-nvim
          flash-nvim
          friendly-snippets
          gitsigns-nvim
          grug-far-nvim
          lazydev-nvim
          LazyVim
          lualine-nvim
          mini-ai
          mini-icons
          mini-pairs
          noice-nvim
          nui-nvim
          nvim-lint
          nvim-lspconfig
          nvim-treesitter-textobjects
          nvim-ts-autotag
          persistence-nvim
          plenary-nvim
          snacks-nvim
          todo-comments-nvim
          tokyonight-nvim
          treesitter
          trouble-nvim
          ts-comments-nvim
          which-key-nvim
          { name = "catppuccin"; path = catppuccin-nvim; }
        ];

        mkEntryFromDrv = drv:
          if lib.isDerivation drv then
            { name = "${lib.getName drv}"; path = drv; }
          else
            drv;

        lazyPath = pkgs.linkFarm "lazy-plugins" (builtins.map mkEntryFromDrv plugins);
      in
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
            path = "${lazyPath}",
            patterns = { "" },
          },
          spec = {
            { "LazyVim/LazyVim", import = "lazyvim.plugins" },
            { "mason-org/mason-lspconfig.nvim", enabled = false },
            { "mason-org/mason.nvim", enabled = false },
            -- { import = "plugins" },
            {
              "nvim-treesitter/nvim-treesitter",
              opts = {
                install_dir = "${treesitterGrammars}",
              }
            },
          },
        })
    '';
  };

  xdg.configFile."nvim/lua".source = mkSymlink
    "${config.home.homeDirectory}/nix-config/home/editors/nvim/conf";
}
