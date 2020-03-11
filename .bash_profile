eval "$(rbenv init -)"

ssh-add -K ~/.ssh/id_rsa

parse_git_branch(){
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export PS1="\u@\h \W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "
export LSCOLORS="cx"

export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin

export NODE_OPTIONS=--max-old-space-size=4096

[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion || {
    # if not found in /usr/local/etc, try the brew --prefix location
    [ -f "$(brew --prefix)/etc/bash_completion.d/git-completion.bash" ] && \
        . $(brew --prefix)/etc/bash_completion.d/git-completion.bash
}

alias ls='ls -lGp'
alias gst='git status'
alias gco='git checkout'
alias reset-db='bundle exec rake db:reset db:seed_convenience'


clean_branches() {
  git remote prune origin
  git branch -vv | grep "origin/.*: gone]" | awk '{print $1}' | xargs git branch -D
}
