#!/bin/bash

# Get the os type
OS_TYPE=$(uname -s)

# Define colors for errors, warnings and success messages
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
PREFERRED_FONT="JetBrainsMono"

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

update_package_list() {
    sudo apt-get update
}

is_brew_installed() {
    if brew --version &> /dev/null; then
        return 0
    else
        return 1
    fi
}

install_brew() {
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

install_zsh_linux() {
    sudo apt-get install zsh
}

install_zsh_darwin() {
    brew install zsh
}

install_stow_linux() {
    sudo apt-get install stow
}

install_stow_darwin() {
    brew install stow
}

install_oh_my_zsh() {
    print_step "Installing Oh My Zsh"
    # Remove .oh-my-zsh at the home directory if it exists
    rm -rf ~/.oh-my-zsh
    # Install Oh My Zsh without launching an interactive session
    RUNZSH=no /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

install_oh_my_posh_darwin() {
    brew install jandedobbeleer/oh-my-posh/oh-my-posh
}

install_oh_my_posh_linux() {
    curl -s https://ohmyposh.dev/install.sh | bash -s
}

install_nerd_font_using_oh_my_posh() {
    oh-my-posh font install $PREFERRED_FONT
}

configure_installed_font_darwin() {
    # Set the font for iTerm2
    defaults write com.googlecode.iterm2 "Normal Font" -string "$PREFERRED_FONT-Regular 14"
    defaults write com.googlecode.iterm2 "Non Ascii Font" -string "$PREFERRED_FONT-Regular 14"
}
install_tmux_darwin() {
    brew install tmux
}

install_tmux_linux() {
    sudo apt-get install tmux
}

# Get the os type
OS_TYPE=$(uname -s)

# For linux based systems
if [ "$OS_TYPE" == "Linux" ]; then
    print_step "Installing dependencies for Linux"
    execute_step "Updating package list" update_package_list
    execute_step "Installing Zsh" install_zsh_linux
    execute_step "Installing Stow" install_stow_linux
    execute_step "Installing Oh My Zsh" install_oh_my_zsh
    execute_step "Installing Oh My Posh" install_oh_my_posh_linux
    execute_step "Installing Nerd Font using Oh My Posh" install_nerd_font_using_oh_my_posh
    execute_step "Installing Tmux" install_tmux_linux

# For macOS based systems
elif [ "$OS_TYPE" == "Darwin" ]; then
    print_step "Installing dependencies for macOS"
    if ! is_brew_installed; then
        execute_step "Installing Homebrew" install_brew
    fi
    execute_step "Installing Stow" install_stow_darwin
    execute_step "Installing Zsh" install_zsh_darwin
    execute_step "Installing Oh My Zsh" install_oh_my_zsh
    execute_step "Installing Oh My Posh" install_oh_my_posh_darwin
    execute_step "Installing Nerd Font using Oh My Posh" install_nerd_font_using_oh_my_posh
    execute_step "Configuring installed font" configure_installed_font_darwin
    execute_step "Installing Tmux" install_tmux_darwin
fi