alias resource='source ~/.zshrc'
alias zrc='vim ~/dotfiles/.zshrc'
alias ls='ls -aL'
alias e='exit'

# Begin git util functions
gg() {
    git add . && git commit -m "$@" && git push
}

ga() {
    git add . && git commit --amend && git push -f
}

gs() {
    git add . && git commit -m "$@"
}

alias gb='git branch'

pp() {
    git pull
}

# End git util functions

pi() {
    ssh "pi@pi$@.local"
}

listening() {
    lsof -i :$1 | grep LISTEN
}

listeningkill() {
    pid=$(listening $1 | awk '{print $2}')
    echo "killing $pid"
    kill $pid
    echo "dead."
}

parse_git_branch() {
    b=$(git branch --show-current 2> /dev/null) || return
    if [[ $b = 'master' ]]; then
        echo "[\e[31m$b\e[0m] "
    else
        echo "[\e[36m$b\e[0m] "
    fi

}

set -o PROMPT_SUBST
export PS1='$(parse_git_branch)$(whoami)@ %~ %# '

echo "Ayy lmao"

