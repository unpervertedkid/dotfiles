# Define colors for errors, warnings and success messages
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'

# Reset color
NC='\033[0m'

print_error() {
    echo -e "${RED}Error: $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}Warning: $1${NC}"
}

print_success() {
    echo -e "${GREEN}Success: $1${NC}"
}

print_step() {
    step=$1
    echo
    echo "----------------------------------------"
    echo "$step"
    echo "----------------------------------------"
    echo
}

execute_step() {
    stepName=$1
    stepFunction=$2

    print_step "$stepName"
    if $stepFunction; then
        print_success "$stepName completed successfully"
    else
        print_error "Failed to complete $stepName"
        exit 1
    fi
}

setUpStowForDirectory() {
    dir=$1
    stow_dir_path="$PWD/$dir" # Path to the stow directory

    if [ ! -d "$stow_dir_path" ]; then
        echo "Error: Directory $stow_dir_path does not exist."
        return 1
    fi

    # Remove existing conflicting files
    echo "Checking for conflicts..."
    find "$stow_dir_path" -type f -exec basename {} \; | while read -r file; do
        target="$HOME/$file"
        if [ -e "$target" ] && [ ! -L "$target" ]; then
            echo "Removing existing file: $target"
            rm -f "$target"
        fi
    done

    # Stow the directory
    stow -v --target="$HOME" "$dir"
}

setUpStow() {
    for dir in */; do
        if [ "$dir" != "scripts/" ]; then
            setUpStowForDirectory "$dir"
        fi
    done
}



execute_step "Setting up stow" setUpStow