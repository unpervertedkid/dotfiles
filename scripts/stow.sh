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
    stow --adopt "$dir"
}

setUpStow() {
    for dir in */; do
        if [ "$dir" != "scripts/" ]; then
            stow --adopt "$dir"
        fi
    done
}



execute_step "Setting up stow" setUpStow