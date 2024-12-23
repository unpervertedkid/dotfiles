# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Zsh theme
ZSH_THEME="robbyrussell"

source $ZSH/oh-my-zsh.sh

# Oh my posh configuration
eval "$(oh-my-posh init zsh --config 'https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/catppuccin_frappe.omp.json')"

# User configuration

# Aliases
# 1. Quick launch aliases
alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"

# 2. Tool aliases
alias vim="nvim"
