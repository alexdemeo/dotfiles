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

alias gs='git status'
alias gb='git branch'
alias pp='git pull'

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

clean-copied-json() {
    res=$(pbpaste)
    res=$(echo $res | sed 's/"\(.*\)":/\1:/g')
    res=$(echo $res | sed 's/"\(202.*Z\)",/new Date("\1"),/g')
    res=$(echo $res | sed "s/\"/'/g")
    echo $res
    pbcopy <<< $res
}

parse_git_branch() {
    b=$(git branch --show-current 2> /dev/null) || return

    l='['
    if [[ $b = 'master' ]]; then
        l+="\\033[31m"
    else
        l+="\\033[36m"
    fi

    l+="$b\\033[0m] "
    echo $l
}

set -o PROMPT_SUBST
export PS1='$(parse_git_branch)$(whoami)@ %~ %# '

echo "Ayy lmao"

