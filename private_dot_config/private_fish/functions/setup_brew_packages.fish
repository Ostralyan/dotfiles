function setup_brew_packages -d "Install every Brewfile in ~/.config/homebrew"
    set -l dir ~/.config/homebrew

    if not command -q brew
        echo "brew not found — install Homebrew first: https://brew.sh"
        return 1
    end

    if not test -f $dir/Brewfile
        echo "No Brewfile at $dir/Brewfile"
        return 1
    end

    # Brewfile is the shared core. The optional ones are only written to disk
    # when `personal = true` in ~/.config/chezmoi/chezmoi.toml, so a plain
    # `test -f` is the whole gate.
    for f in $dir/Brewfile $dir/Brewfile.rig $dir/Brewfile.apps
        test -f $f; or continue
        echo ""
        echo "==> "(basename $f)
        brew bundle install --file=$f; or return 1
    end

    bat cache --build
end
