# Homebrew's rustup is keg-only and no longer ships rustup-init: its bin holds
# rustup plus the cargo/rustc proxies, and nothing writes ~/.cargo/env.fish.
if test -d /opt/homebrew/opt/rustup/bin
    fish_add_path --path /opt/homebrew/opt/rustup/bin
end

# A curl (rustup-init) install writes this instead, putting ~/.cargo/bin first.
if test -f $HOME/.cargo/env.fish
    source $HOME/.cargo/env.fish
end
