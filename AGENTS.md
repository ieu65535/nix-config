# AGENTS.md — nix-config

## Project

Single-host NixOS flake + Home Manager (as NixOS module).  
Host: `hyper` | User: `ieu` | Platform: `x86_64-linux` (Hyper‑V guest)

Home Manager is **not standalone** — it is integrated via `home-manager.nixosModules.home-manager`. Run `nixos-rebuild`, never `home-manager switch`.

State versions: NixOS `25.11`, Home Manager `26.05`.

## Key commands

| Action | Command |
|---|---|
| Build + activate | `sudo nixos-rebuild switch --flake .#hyper` |
| Dry build | `nixos-rebuild dry-build --flake .#hyper` |
| Dry activate | `nixos-rebuild dry-activate --flake .#hyper` |
| Update all inputs | `nix flake update` |
| Update one input | `nix flake update <name>` |
| Check flake | `nix flake check` |
| Evaluate | `nix eval .#nixosConfigurations.hyper` |

## Architecture

```
flake.nix
├── inputs: nixpkgs (unstable), home-manager (follows nixpkgs), noctalia (cachix branch)
└── outputs
    └── nixosConfigurations.hyper
         ├── hosts/hyper/configuration.nix   # system config
         │     └── imports: hardware-configuration.nix
         └── home-manager (module)
               └── users/ieu/home.nix         # user packages & programs

`inputs` is passed to NixOS modules via `specialArgs` and to Home Manager modules via `home-manager.extraSpecialArgs` separately — they use independent module systems and args do not cross over.
```

Only output exposed: `nixosConfigurations.hyper`. No `packages`, `devShells`, `formatter`, `checks`, or standalone `homeConfigurations`.

## Conventions

- **Cachix**: `noctalia.cachix.org` + `nix-community.cachix.org` configured as substituters.
- **Mirrors**: TUNA / USTC Chinese mirrors with priority set in `nix.settings.substituters`.
- **Auth**: SSH key only — password auth and root login disabled.
- **Git default branch**: `main` (set in home.nix).

## What is missing (intentionally)

No CI, no formatter (no `treefmt`/`nixfmt`/`alejandra`), no linter, no dev shell, no tests, no pre‑commit hooks, no README. Reference configs from other projects live in `refs/` (gitignored).
