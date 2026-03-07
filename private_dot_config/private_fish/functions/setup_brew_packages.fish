function setup_brew_packages -d "Installs all my used brew packages"
  brew install atuin bat eza fd fisher fzf go neovim pgcli ripgrep rustup starship tmux zoxide chezmoi awscli uv 
  brew install --cask alt-tab claude claude-code ghostty spotify claude gcloud-cli itsycal rectangle font-fantasque-sans-mono-nerd-font iina figma thebrowsercompany-dia sidebar slack session-manager-plugin raycast orbstack notion linear-linear homerow aerospace

  bat cache --build
end

