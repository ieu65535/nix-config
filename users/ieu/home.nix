{
  imports = [
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
  };
}
