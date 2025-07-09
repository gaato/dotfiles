# Dotfiles via Home Manager

This repository now provides a [home-manager](https://github.com/nix-community/home-manager) configuration.

## Usage

1. Install Nix and home-manager.
2. Build the configuration for your user:

   ```
   nix build .#homeConfigurations.user.activationPackage
   ```

   Replace `user` with your login name if different.

3. Activate the configuration:

   ```
   ./result/activate
   ```

This will place the dotfiles from this repository into your home directory.

The configuration also installs some useful packages like `git`, `fzf`,
`zoxide`, `eza`, `neovim`, `wezterm`, and `emacs` so that the provided
dotfiles work out of the box.

