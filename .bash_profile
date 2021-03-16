set -o vi
export EDITOR='vim'
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
# export PS1="\[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\]\r\n$ "
export PATH="$PATH:/Users/jakobhillerstrom/.dotnet/tools"
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '%F{240}(%b)%r%f'
zstyle ':vcs_info:*' enable git

[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh
export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
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
alias reload-sa="brew services stop yabai && sudo yabai --uninstall-sa && sudo yabai --install-sa && brew services start yabai && sudo yabai --load-sa"
export LC_ALL=en_US.UTF-8  
export LANG=en_US.UTF-8
