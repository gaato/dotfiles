# Dotfiles by @gaato

This repository contains my personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).

## Features

- **Zsh Configuration**: Modular zsh setup with plugins via znap
- **Environment Management**: Support for pyenv, goenv, nvm
- **Editor Configs**: Vim, Nano, Neovim configurations
- **Terminal**: Wezterm configuration
- **Emacs**: Doom Emacs configuration

## Quick Start

### Prerequisites

- **chezmoi**: Install chezmoi first
  ```bash
  # On Arch Linux
  sudo pacman -S chezmoi
  
  # Or using the install script
  sh -c "$(curl -fsLS get.chezmoi.io)"
  ```

### Installation

1. **Clone and initialize** (first time setup):
   ```bash
   chezmoi init --apply https://github.com/gaato/dotfiles.git
   ```

2. **Or use the provided script**:
   ```bash
   git clone https://github.com/gaato/dotfiles.git
   cd dotfiles
   ./install.zsh init
   ```

### Usage

#### Management Commands

```bash
# Check what would be changed
chezmoi diff

# Apply changes
chezmoi apply

# Update from repository
chezmoi update

# Check status
chezmoi status

# Edit a file (opens in configured editor)
chezmoi edit ~/.zshrc
```

#### Using the install script

```bash
# Apply dotfiles
./install.zsh apply

# Update from repository
./install.zsh update

# Show differences
./install.zsh diff

# Show status
./install.zsh status
```

## Structure

```
dotfiles/
├── .zshrc                 # Main zsh configuration
├── .zshrc.d/             # Modular zsh configuration
│   ├── 00_prompt.zsh     # Prompt configuration
│   ├── 10_znap_plugins.zsh # Plugin management
│   ├── 20_fzf.zsh        # FZF configuration
│   ├── 30_env.zsh        # Environment variables
│   ├── 40_history_aliases.zsh # History and aliases
│   └── 50_theme.zsh      # Theme configuration
├── .config/
│   ├── nvim/             # Neovim configuration
│   ├── wezterm/          # Wezterm terminal configuration
│   └── doom/             # Doom Emacs configuration
├── .vimrc                # Vim configuration
├── .nanorc               # Nano configuration
└── install.zsh           # Installation and management script
```

## Customization

### Local Configuration

Create `~/.zshrc.local` for machine-specific settings that shouldn't be version controlled:

```bash
# Example ~/.zshrc.local
export WORK_ENV="production"
alias work-connect="ssh user@work-server"
```

### Adding New Files

```bash
# Add a new file to chezmoi
chezmoi add ~/.newconfig

# Edit existing managed file
chezmoi edit ~/.zshrc

# Apply changes
chezmoi apply
```

### Templating

chezmoi supports templating for machine-specific configurations. Files can be made into templates by adding `.tmpl` extension in the source.

Example for conditional configuration:
```bash
# In chezmoi source: dot_zshrc.tmpl
{{- if eq .chezmoi.hostname "work-laptop" }}
export WORK_MODE=true
{{- end }}
```

## Zsh Plugins

Plugins are managed via [znap](https://github.com/marlonrichert/zsh-snap). See `.zshrc.d/10_znap_plugins.zsh` for current plugins.

To add a new plugin:
```bash
chezmoi edit ~/.zshrc.d/10_znap_plugins.zsh
# Add: znap source author/plugin-name
chezmoi apply
```

## Migration from Previous Setup

If you were using the old `setup.zsh` script:

1. Remove old symlinks:
   ```bash
   # Remove existing symlinks (backup important files first!)
   rm ~/.zshrc ~/.vimrc ~/.nanorc
   rm -rf ~/.zshrc.d ~/.config/nvim ~/.config/wezterm ~/.config/doom
   ```

2. Initialize with chezmoi:
   ```bash
   chezmoi init --apply https://github.com/gaato/dotfiles.git
   ```

## License

This project is licensed under the MIT License - see the LICENSE file for details.
