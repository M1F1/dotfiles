# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/pl8000255/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/pl8000255/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/pl8000255/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/pl8000255/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"
export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"
eval "$(zoxide init zsh)"
source <(fzf --zsh)

source ~/dotfiles/scripts/conda_env_list_and_activate.sh
alias ca="conda-env-list-and-activate"
