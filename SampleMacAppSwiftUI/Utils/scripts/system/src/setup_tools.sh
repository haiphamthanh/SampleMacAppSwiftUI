#!/bin/bash

# Install oh-my-zsh (https://ohmyz.sh/)
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install homebrew (https://brew.sh/)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install git (https://git-scm.com/download/mac)
brew install git

# Install cmd-line json processing (https://stedolan.github.io/jq/download/)
brew install jq

# Install cocoa pods (https://cocoapods.org/)
# Install with brew instead of gem if you want to get error (https://developer.apple.com/forums/thread/652822)
brew install cocoapods