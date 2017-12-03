# ~/.bash_profile

if [[ -z $(pidof gpg-agent) ]]; then
  gpg-agent --daemon --disable-scdaemon
fi

[[ -f ~/.bashrc ]] && . ~/.bashrc

sshoot start nj1

