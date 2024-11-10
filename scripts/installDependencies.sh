# Get the os type
OS_TYPE=$(uname -s)

# For linux based systems
if [ $OS_TYPE == "Linux"]; then 
    # Install zsh
    sudo apt-get install zsh

if [ $OS_TYPE == "Darwin"]; then
    # Ensure brew is installed if not install it
    if ! command -v brew &> /dev/null; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    # Install zsh
    brew install zsh