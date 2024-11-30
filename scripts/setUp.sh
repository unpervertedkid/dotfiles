# This is the main setUp Script
currentDir=$(pwd)
chmod +x scripts/installDependencies.sh
./scripts/installDependencies.sh

chmod +x scripts/stow.sh
./scripts/stow.sh