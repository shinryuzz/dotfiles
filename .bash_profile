
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/shinryuzz/opt/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/shinryuzz/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/shinryuzz/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/shinryuzz/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


export PATH="$HOME/.poetry/bin:$PATH"
export PATH="$HOME/.nodenv/bin:$PATH"
eval "$(nodenv init -)"
export PATH="$HOME/.nodenv/bin:$PATH"
