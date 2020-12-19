set -o vi
export EDITOR='vim'
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\]\r\n$ "
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh
export FZF_DEFAULT_COMMAND='ag --nocolor --ignore node_modules --ignore dist -g ""'
alias vgc="vim ~/.gitconfig"
alias vbp="vim ~/.bash_profile"
alias sbp="source ~/.bash_profile"
alias cd..="cd .."
alias ..="cd .."
alias lines="ag --nobreak --noheading . | fzf"
alias g="git"
alias winc="cd ~/Parallels/Windows\ 10.pvm/Windows\ Disks/C"
alias jb="jobs"
export LC_ALL=en_US.UTF-8  
export LANG=en_US.UTF-8
