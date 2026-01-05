function setup_brew_packages -d "Installs all my used brew packages"
  brew install atuin bat eza fd fisher fzf go neovim pgcli procs ripgrep rustup starship tmux zoxide chezmoi awscli uv pyenv
  brew install --cask alt-tab claude-code ghostty jordanbaird-ice spotify claude gcloud-cli itsycal linear-linear rectangle stats font-caskaydia-cove-nerd-font font-fantasque-sans-mono-nerd-font font-fira-code-nerd-font font-hasklug-nerd-font font-lilex-nerd-font iina slack

  bat cache --build
end

