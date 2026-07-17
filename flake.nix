{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    noctalia.url = "github:noctalia-dev/noctalia/cachix";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-gaming = {
      url = "github:fufexan/nix-gaming";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nixpak = {
    #   url = "github:nixpak/nixpak";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # anime-games-launcher = {
    #   url = "github:an-anime-team/anime-games-launcher";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  nixConfig = {
    extra-substituters = [
      "https://noctalia.cachix.org"
      "https://nix-community.cachix.org"
      "https://nix-gaming.cachix.org"
      # "https://anime-games-launcher.cachix.org"
    ];
    extra-trusted-public-keys = [
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
      # "anime-games-launcher.cachix.org-1:kFD3H8Ft2naaCDhUKOoGvRLqs2NRlFh8QMSiSfm0tbQ="
    ];
  };

  outputs = inputs@{
    self,
    nixpkgs,
    home-manager,
    # anime-games-launcher,
    ...
  }: {
    nixosConfigurations = {
      hyper = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/hyper/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.ieu = import ./users/ieu/home.nix;
          }
        ];
      };
      desk-arc = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/desk-arc
          # anime-games-launcher.nixosModules.anime-games-launcher
          home-manager.nixosModules.home-manager
        ];
      };
    };
  };
}
