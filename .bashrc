# ---------- FASTFETCH ----------
if [[ $- == *i* ]]; then
    fastfetch

    echo ""
    echo "╭──────────   NIX COMMANDS ──────────╮"
    echo "│ conf       → open nix config        │"
    echo "│ nixr       → rebuild system         │"
    echo "│ editconf   → edit config (kate)     │"
    echo "│ update     → upgrade system         │"
    echo "│ clean      → nix garbage collect    │"
    echo "╰─────────────────────────────────────╯"
    echo ""
fi

# ---------- COMMANDS ----------

conf() {
    echo "📁 Opening system config..."
    kate /etc/nixos/configuration.nix
}

nixr() {
    echo "🔧 Rebuilding NixOS..."
    sudo nixos-rebuild switch
}

editconf() {
    echo "📁 Opening user config..."
    kate ~/.config/sway/config
}

update() {
    echo "⬆ Updating system..."
    sudo nixos-rebuild switch --upgrade
}

clean() {
    echo "🧹 Cleaning nix store..."
    sudo nix-collect-garbage -d
}

# Prompt

PS1="\[\e[38;5;111m\]  \[\e[38;5;245m\]\W \[\e[38;5;111m\]❯ \[\e[0m\]"



# Smart History
HISTSIZE=10000
HISTFILESIZE=20000
shopt -s histappend
PROMPT_COMMAND="history -a; history -n"




# NAVIGATION
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# auto list files when entering folder
cd() {
    builtin cd "$@" && ls --color=auto
}



# smoother readline
bind "set completion-ignore-case on"
bind "set show-all-if-ambiguous on"
bind "TAB:menu-complete"



# colored ls
alias ls='ls --color=auto'
