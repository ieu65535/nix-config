# AGENTS.md — nix-config

## Project

Two-host NixOS flake + Home Manager (as NixOS module), both `x86_64-linux`, user `ieu`:

- **`desk-arc`** — the actively developed desktop (Intel, niri + `noctalia`/`dms` shell). Default build target.
- **`hyper`** — older Hyper-V guest config, largely stale. Don't assume edits target this.

Home Manager is **not standalone** — integrated via `home-manager.nixosModules.home-manager`. Run `nixos-rebuild`, never `home-manager switch`.

## Key commands

| Action | Command |
|---|---|
| Build + activate | `sudo nixos-rebuild switch --flake .#desk-arc` |
| Dry build | `nixos-rebuild dry-build --flake .#desk-arc` |
| Dry activate | `nixos-rebuild dry-activate --flake .#desk-arc` |
| Evaluate | `nix eval .#nixosConfigurations.desk-arc` |
| Update one input | `nix flake update <name>` |

No CI, formatter, linter, dev shell, tests, or pre-commit hooks — don't invent them.

## Architecture (desk-arc — the live path)

```
flake.nix -> nixosConfigurations.{desk-arc, hyper}
└── hosts/desk-arc/default.nix            # system module
     ├── imports: ./configuration.nix + modules/* + inputs.noctalia-greeter
     └── home-manager.users.ieu = import ./hosts/desk-arc/home.nix
           ├── home/desktop               # options.desktop.shell = "noctalia" | "dms"; imports ../noctalia ../niri ./dms.nix
           ├── users/ieu/home.nix         # shared base: kitty, vscode, chrome, fcitx5, git, fish
           └── home/gaming.nix            # lutris/steam/mangohud + callPackage ../pkgs/maa-cli/package.nix
```

- `inputs` reach NixOS modules via `specialArgs` and Home Manager via `home-manager.extraSpecialArgs` separately — the two module systems do not share args.
- `hyper` differs: `home-manager.users.ieu = import ./users/ieu/home.nix` (no desktop/gaming).
- `modules/*` (security, hardware-intel, gaming, virtualisation, i18n, clash, btrfs) are shared NixOS modules imported only by `hosts/desk-arc/default.nix`.
- `hardening/` (bwraps/nixpaks) is **not imported anywhere** — experimental scratch; leave alone.
- `refs/` holds reference configs from other projects (gitignored).

## Gotchas

- All inputs are `git+ssh://git@github.com/...` — building/fetching requires GitHub SSH keys; there is no HTTPS fallback. `nixpkgs` is pinned to a specific rev in `flake.nix`; `nix flake update` only bumps the unpinned inputs.
- Desk-arc depends on the checkout living at **`~/nix-config`**: niri/noctalia configs (`home/niri/conf/*`, `home/noctalia/conf/*`, `hosts/desk-arc/niri-hardware.kdl`) are `mkOutOfStoreSymlink`'d from the live checkout, so edits take effect on the next rebuild only if the path matches.
- `system.stateVersion` differs per host: desk-arc `26.11`, hyper `25.11`; `home.stateVersion` is `26.05`. Don't bump unless told.
- `modules/display-manager.nix` defines `display-manager.enable` + `display-manager.greeter` (`dms-greeter`/`noctalia-greeter`/`sddm`) and imports `inputs.noctalia-greeter.nixosModules.default`; the `dms-greeter` case uses nixpkgs' `services.displayManager.dms-greeter`. Configured in `hosts/desk-arc/default.nix`.
- DMS comes from nixpkgs (`pkgs.dms-shell`, `programs.dms-shell`, `services.displayManager.dms-greeter`), not the removed `dms` flake input. `programs.dms-shell` is enabled when `desktop.shell == "dms"` (read from `home-manager.users.ieu`). `hosts/desk-arc/default.nix` carries a `nixpkgs.overlays` override forcing `GOPROXY=https://goproxy.cn,direct` on the go-modules fetch — `proxy.golang.org` is unreachable here.

## Conventions

- Flake `nixConfig` substituters: `noctalia.cachix.org`, `nix-community.cachix.org`, `nix-gaming.cachix.org`. Per-host mirror substituters live in each `configuration.nix` (desk-arc: SJTU+USTC; hyper: TUNA+USTC).
- SSH key auth only. `hyper` explicitly disables password auth/root login; desk-arc just enables `openssh`. Authorized keys are public — commit no private keys or secrets.
- Make the smallest reasonable change; preserve host naming and the per-host configuration split.
