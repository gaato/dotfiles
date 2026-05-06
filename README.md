# dotfiles

Home Manager configuration for `gaato`.

## Standalone

```sh
home-manager switch --flake .#gaato
```

## NixOS module use

Import `home/gaato.nix` from a NixOS flake that already enables Home Manager.
