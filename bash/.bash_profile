# ~/.bash_profile

if [[ -z $(pidof gpg-agent) ]]; then
  gpg-agent --daemon --disable-scdaemon --write-env-file $HOME/.gpg-agent-info
fi

[[ -f ~/.bashrc ]] && . ~/.bashrc

