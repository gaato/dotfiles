#!/usr/bin/env zsh

# chezmoi dotfiles management script
# This script helps with chezmoi installation and setup

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
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
        echo "  # On Arch Linux:"
        echo "  sudo pacman -S chezmoi"
        echo ""
        echo "  # Or using the install script:"
        echo "  sh -c \"\$(curl -fsLS get.chezmoi.io)\""
        exit 1
    fi
    print_success "chezmoi is installed"
}

# Initialize chezmoi with this repository
init_chezmoi() {
    local repo_url="https://github.com/gaato/dotfiles.git"
    
    print_status "Initializing chezmoi with repository: $repo_url"
    
    if [ -d "$HOME/.local/share/chezmoi" ]; then
        print_warning "chezmoi already initialized. Use 'chezmoi update' to pull latest changes."
        return 0
    fi
    
    chezmoi init --apply "$repo_url"
    print_success "chezmoi initialized and dotfiles applied"
}

# Apply dotfiles
apply_dotfiles() {
    print_status "Applying dotfiles..."
    chezmoi apply
    print_success "Dotfiles applied successfully"
}

# Update dotfiles
update_dotfiles() {
    print_status "Updating dotfiles from repository..."
    chezmoi update
    print_success "Dotfiles updated successfully"
}

# Check differences
check_diff() {
    print_status "Checking differences between source and target..."
    chezmoi diff
}

# Main function
main() {
    case "${1:-}" in
        "init")
            check_chezmoi
            init_chezmoi
            ;;
        "apply")
            check_chezmoi
            apply_dotfiles
            ;;
        "update")
            check_chezmoi
            update_dotfiles
            ;;
        "diff")
            check_chezmoi
            check_diff
            ;;
        "status")
            check_chezmoi
            chezmoi status
            ;;
        *)
            echo "Usage: $0 {init|apply|update|diff|status}"
            echo ""
            echo "Commands:"
            echo "  init    - Initialize chezmoi with this repository"
            echo "  apply   - Apply dotfiles to system"
            echo "  update  - Update dotfiles from repository"
            echo "  diff    - Show differences between source and target"
            echo "  status  - Show chezmoi status"
            echo ""
            echo "First time setup:"
            echo "  $0 init"
            echo ""
            echo "Regular updates:"
            echo "  $0 update"
            exit 1
            ;;
    esac
}

main "$@"
