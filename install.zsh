#!/usr/bin/env zsh

# ===========================================
# Enhanced chezmoi dotfiles management script
# This script provides comprehensive dotfiles management with chezmoi
# ===========================================

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Configuration
REPO_URL="https://github.com/gaato/dotfiles.git"
CHEZMOI_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/chezmoi"
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"

# Function to print colored output
print_header() {
    echo -e "${BOLD}${CYAN}=== $1 ===${NC}"
}

print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if chezmoi is installed
check_chezmoi() {
    if ! command -v chezmoi >/dev/null 2>&1; then
        print_error "chezmoi is not installed. Please install it first:"
        echo ""
        echo "  ${BOLD}Installation options:${NC}"
        
        if [[ "$OSTYPE" == "linux-gnu"* ]]; then
            if command -v pacman >/dev/null 2>&1; then
                echo "  # Arch Linux:"
                echo "  sudo pacman -S chezmoi"
            elif command -v apt >/dev/null 2>&1; then
                echo "  # Ubuntu/Debian:"
                echo "  sudo apt install chezmoi"
            elif command -v dnf >/dev/null 2>&1; then
                echo "  # Fedora:"
                echo "  sudo dnf install chezmoi"
            fi
        elif [[ "$OSTYPE" == "darwin"* ]]; then
            echo "  # macOS:"
            echo "  brew install chezmoi"
        fi
        
        echo ""
        echo "  # Universal installer:"
        echo "  sh -c \"\$(curl -fsLS get.chezmoi.io)\""
        echo ""
        echo "  # Go install:"
        echo "  go install github.com/twpayne/chezmoi@latest"
        
        exit 1
    fi
    print_success "chezmoi is installed ($(chezmoi --version | head -n1))"
}

# Create backup of existing dotfiles
backup_existing() {
    print_status "Creating backup of existing dotfiles..."
    
    local files_to_backup=(
        ".zshrc"
        ".zshrc.d"
        ".vimrc"
        ".nanorc"
        ".config/nvim"
        ".config/wezterm"
        ".config/doom"
        ".gitconfig"
        ".ssh/config"
    )
    
    local backup_created=false
    
    for file in "${files_to_backup[@]}"; do
        if [[ -e "$HOME/$file" ]]; then
            if [[ ! -d "$BACKUP_DIR" ]]; then
                mkdir -p "$BACKUP_DIR"
                backup_created=true
            fi
            
            local backup_path="$BACKUP_DIR/$file"
            mkdir -p "$(dirname "$backup_path")"
            cp -r "$HOME/$file" "$backup_path" 2>/dev/null || true
            print_status "Backed up: $file"
        fi
    done
    
    if [[ "$backup_created" == true ]]; then
        print_success "Backup created at: $BACKUP_DIR"
    else
        print_status "No existing dotfiles found to backup"
    fi
}

# Initialize chezmoi with this repository
init_chezmoi() {
    print_header "Initializing chezmoi"
    
    if [[ -d "$HOME/.local/share/chezmoi" ]]; then
        print_warning "chezmoi already initialized. Use 'update' to pull latest changes."
        read "yn?Do you want to reinitialize? This will reset your local changes. [y/N] "
        case $yn in
            [Yy]* ) 
                print_status "Removing existing chezmoi directory..."
                rm -rf "$HOME/.local/share/chezmoi"
                ;;
            * ) 
                print_status "Keeping existing initialization."
                return 0
                ;;
        esac
    fi
    
    backup_existing
    
    print_status "Initializing chezmoi with repository: $REPO_URL"
    chezmoi init --apply "$REPO_URL"
    print_success "chezmoi initialized and dotfiles applied"
    
    print_status "Running post-installation setup..."
    post_install_setup
}

# Apply dotfiles
apply_dotfiles() {
    print_header "Applying dotfiles"
    check_chezmoi
    
    print_status "Applying dotfiles..."
    chezmoi apply --verbose
    print_success "Dotfiles applied successfully"
}

# Update dotfiles
update_dotfiles() {
    print_header "Updating dotfiles"
    check_chezmoi
    
    print_status "Checking for updates..."
    if chezmoi git -- fetch --dry-run 2>/dev/null; then
        print_status "Updates available. Pulling changes..."
        chezmoi update --verbose
        print_success "Dotfiles updated successfully"
    else
        print_status "No updates available"
    fi
}

# Check differences
check_diff() {
    print_header "Checking differences"
    check_chezmoi
    
    print_status "Checking differences between source and target..."
    if chezmoi diff --no-pager; then
        print_success "No differences found"
    else
        print_warning "Differences found above"
    fi
}

# Show status
show_status() {
    print_header "Status"
    check_chezmoi
    
    print_status "chezmoi status:"
    chezmoi status
    
    print_status "Managed files:"
    chezmoi managed | head -20
    local managed_count=$(chezmoi managed | wc -l)
    if [[ $managed_count -gt 20 ]]; then
        echo "... and $((managed_count - 20)) more files"
    fi
}

# Edit configuration
edit_config() {
    print_header "Editing configuration"
    check_chezmoi
    
    case "${2:-}" in
        "data")
            chezmoi edit "$HOME/.local/share/chezmoi/.chezmoidata.toml"
            ;;
        "config")
            chezmoi edit-config
            ;;
        *)
            print_status "Available configurations:"
            echo "  data   - Edit data variables (.chezmoidata.toml)"
            echo "  config - Edit chezmoi configuration"
            echo ""
            echo "Usage: $0 edit {data|config}"
            ;;
    esac
}

# Add new files to chezmoi
add_files() {
    print_header "Adding files to chezmoi"
    check_chezmoi
    
    if [[ $# -lt 2 ]]; then
        print_error "Please specify files to add"
        echo "Usage: $0 add <file1> [file2] ..."
        exit 1
    fi
    
    shift # Remove 'add' from arguments
    
    for file in "$@"; do
        if [[ -e "$file" ]]; then
            print_status "Adding $file to chezmoi..."
            chezmoi add "$file"
            print_success "Added: $file"
        else
            print_error "File not found: $file"
        fi
    done
}

# Post-installation setup
post_install_setup() {
    print_status "Checking shell configuration..."
    
    if [[ "$SHELL" != */zsh ]]; then
        print_warning "Current shell is not zsh: $SHELL"
        print_status "To change your shell to zsh, run:"
        echo "  chsh -s \$(which zsh)"
    fi
    
    # Check if p10k is available and needs configuration
    if command -v p10k >/dev/null 2>&1 && [[ ! -f "$HOME/.p10k.zsh" ]]; then
        print_status "Powerlevel10k detected but not configured."
        print_status "Run 'p10k configure' after restarting your shell."
    fi
    
    print_success "Setup complete! Restart your shell or run: source ~/.zshrc"
}

# Clean up chezmoi
cleanup_chezmoi() {
    print_header "Cleaning up"
    check_chezmoi
    
    print_warning "This will remove all chezmoi data and managed files!"
    read "yn?Are you sure you want to continue? [y/N] "
    case $yn in
        [Yy]* ) 
            backup_existing
            chezmoi purge --force
            print_success "chezmoi cleaned up. Backup created at: $BACKUP_DIR"
            ;;
        * ) 
            print_status "Cleanup cancelled"
            ;;
    esac
}

# Show help
show_help() {
    cat << EOF
${BOLD}Enhanced chezmoi dotfiles management script${NC}

${BOLD}USAGE:${NC}
    $0 <command> [options]

${BOLD}COMMANDS:${NC}
    ${CYAN}init${NC}      Initialize chezmoi with this repository (first time setup)
    ${CYAN}apply${NC}     Apply dotfiles to system
    ${CYAN}update${NC}    Update dotfiles from repository
    ${CYAN}diff${NC}      Show differences between source and target
    ${CYAN}status${NC}    Show chezmoi status and managed files
    ${CYAN}edit${NC}      Edit configuration files
                 - edit data: Edit template data variables
                 - edit config: Edit chezmoi configuration
    ${CYAN}add${NC}       Add new files to chezmoi management
                 Usage: $0 add <file1> [file2] ...
    ${CYAN}cleanup${NC}   Remove chezmoi and all managed files (with backup)
    ${CYAN}help${NC}      Show this help message

${BOLD}EXAMPLES:${NC}
    # First time setup
    $0 init

    # Regular updates
    $0 update

    # Check what would change
    $0 diff

    # Add a new config file
    $0 add ~/.gitconfig

    # Edit template variables
    $0 edit data

${BOLD}FIRST TIME SETUP:${NC}
    1. Install chezmoi (see installation options above)
    2. Run: $0 init
    3. Restart your shell or run: source ~/.zshrc
    4. Optionally run: p10k configure (for prompt theme)

${BOLD}DAILY USAGE:${NC}
    - Use '$0 update' to get latest changes
    - Use '$0 diff' to see what would change before applying
    - Use '$0 add <file>' to start managing new dotfiles

For more information about chezmoi, visit: https://www.chezmoi.io/
EOF
}

# Main function
main() {
    case "${1:-}" in
        "init")
            check_chezmoi
            init_chezmoi
            ;;
        "apply")
            apply_dotfiles
            ;;
        "update")
            update_dotfiles
            ;;
        "diff")
            check_diff
            ;;
        "status")
            show_status
            ;;
        "edit")
            edit_config "$@"
            ;;
        "add")
            add_files "$@"
            ;;
        "cleanup")
            cleanup_chezmoi
            ;;
        "help"|"--help"|"-h")
            show_help
            ;;
        "")
            print_error "No command specified"
            echo ""
            show_help
            exit 1
            ;;
        *)
            print_error "Unknown command: $1"
            echo ""
            show_help
            exit 1
            ;;
    esac
}

main "$@"
