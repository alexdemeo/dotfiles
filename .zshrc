alias resource='source ~/.zshrc'
alias zrc='vim ~/.zshrc'
alias ls='ls -aL'
alias e='exit'
alias code='cursor'

# Begin git util functions

git_main_branch () {
    git branch | cut -c 3- | grep -E '^master$|^main$'
}

gg() {
    git add . && git commit -m "$@" && git push
}

ga() {
    git add . && git commit --amend && git push -f
}

gc() {
    git add . && git commit -m "$@"
}

gri() {
  main_branch=$(git_main_branch)
  echo "main branch is $main_branch"
  merge_base=$(git merge-base $main_branch HEAD)
  echo "merge base is $merge_base"
  git rebase -i $merge_base
}

alias gs='git status'
alias gb='git branch'
alias pp='git pull'

# End git util functions

# cd to a file goes to its directory
cd() {
    if [ -f "$*" ]; then
        builtin cd "$(dirname "$*")"
    elif [ -z "$*" ]; then # zero length string
        builtin cd
    else
        builtin cd "$*"
    fi
}

pi() {
    ssh "pi@pi$@.local"
}

listening() {
    lsof -i :$1 | grep LISTEN
}

listeningkill() {
    pid=$(listening $1 | awk '{print $2}')
    echo "killing $pid"
    kill -9 $pid
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
    if [[ $b = 'master' || $b = 'main' ]]; then
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

