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
        l+='%F{red}'
    else
        l+='%F{cyan}'
    fi

    l+=$b'%f] '
    echo $l
}

setopt prompt_subst
PROMPT=$'$(parse_git_branch)$(whoami)@ %~ %# '

#precmd_functions+=(prompt)

echo "Ayy lmao"

