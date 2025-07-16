# Dotfiles by @gaato

This repository contains my personal dotfiles managed with [chezmoi](https://www.chezmoi.io/) for cross-platform configuration management.

## ✨ Features

### 🚀 Dynamic Configuration
- **OS Detection**: Automatic Linux/macOS/Windows configuration
- **Environment Switching**: Personal/Work environment profiles
- **Template System**: Dynamic config generation based on system info

### 🔧 Managed Applications
- **Zsh**: Modular configuration with znap plugin manager
- **Development Tools**: pyenv, goenv, nvm auto-setup
- **Editors**: Vim, Nano, Neovim configurations  
- **Terminal**: Wezterm with custom themes
- **Emacs**: Doom Emacs configuration
- **Shell Enhancements**: fzf, powerlevel10k, syntax highlighting

### 🎯 Smart Features
- **Arch Linux Detection**: Auto-enables Arch-specific plugins
- **Feature Toggles**: Enable/disable tools via configuration flags
- **Template Variables**: User info, paths, preferences in one place

## 🚀 Quick Start

### Prerequisites

Install chezmoi:
```bash
# Arch Linux
sudo pacman -S chezmoi

# Other systems
sh -c "$(curl -fsLS get.chezmoi.io)"
```

### Installation

#### Method 1: Direct chezmoi setup
```bash
chezmoi init --apply https://github.com/gaato/dotfiles.git
```

#### Method 2: Using install script
```bash
git clone https://github.com/gaato/dotfiles.git
cd dotfiles
./install.zsh init
```

## 🔧 Management

### Daily Commands
```bash
# Check status
./install.zsh status

# See what would change  
./install.zsh diff

# Apply updates
./install.zsh update

# Full re-initialization
./install.zsh init
```

### Advanced chezmoi usage
```bash
# Edit configuration data
chezmoi edit-config-template

# Add new files
chezmoi add ~/.newfile

# Interactive diff and apply
chezmoi diff
chezmoi apply
```

## 📁 Repository Structure

```
dotfiles/
├── .chezmoidata.toml          # Configuration variables
├── .chezmoiignore            # Files to ignore  
├── .zshrc                    # Main zsh configuration
├── .zshrc.d/                 # Modular zsh configs
│   ├── 00_prompt.zsh         # Prompt configuration
│   ├── 10_znap_plugins.zsh.tmpl  # Plugin management (template)
│   ├── 20_fzf.zsh.tmpl       # FZF configuration (template)
│   ├── 30_env.zsh.tmpl       # Environment setup (template)
│   ├── 40_history_aliases.zsh.tmpl  # History & aliases (template)
│   └── 50_theme.zsh          # Theme configuration
├── .config/                  # Application configurations
│   ├── doom/                 # Doom Emacs config
│   ├── nvim/                 # Neovim config
│   └── wezterm/              # Terminal config
├── install.zsh               # Installation & management script
└── run_once_after_install.sh.tmpl  # Post-install setup (template)
```

## ⚙️ Configuration

### Environment Variables (.chezmoidata.toml)

Customize your setup by editing the configuration variables:

```toml
# Environment type
personal = true          # Enable personal configurations
work = false            # Enable work-specific settings

# Feature flags  
use_p10k = true         # Enable Powerlevel10k prompt
use_fzf = true          # Enable fuzzy finder
use_znap = true         # Enable znap plugin manager
use_nvm = true          # Enable Node.js version manager
use_pyenv = true        # Enable Python version manager
use_goenv = true        # Enable Go version manager

# User information (used in templates)
name = "Your Name"
email = "your.email@example.com"
github_username = "yourusername"
```

### Adding New Files

```bash
# Add a new file to chezmoi management
chezmoi add ~/.newconfig

# Add a template file
chezmoi add --template ~/.config/app/config.yaml

# Add executable script
chezmoi add --executable ~/bin/script.sh
```

### Troubleshooting

#### Reset and re-apply
```bash
rm -rf ~/.local/share/chezmoi
./install.zsh init
```

#### Check what chezmoi would do
```bash
chezmoi diff --verbose
```

#### Manual template testing
```bash
chezmoi execute-template '{{ .use_fzf }}'
```

## 🔄 Migration from Symlinks

This repository was migrated from a symlink-based system to chezmoi templates. The migration:

1. ✅ Replaced static configs with dynamic templates
2. ✅ Added OS/environment detection
3. ✅ Implemented feature toggles
4. ✅ Maintained modular structure
5. ✅ Added automated setup scripts

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [chezmoi](https://www.chezmoi.io/) - Dotfiles management
- [znap](https://github.com/marlonrichert/zsh-snap) - Zsh plugin manager  
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k) - Zsh theme
- [Doom Emacs](https://github.com/doomemacs/doomemacs) - Emacs configuration

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
