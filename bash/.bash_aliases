alias qb="qutebrowser --backend webengine"
alias less=$PAGER
alias zless=$PAGER
alias vc="~/bin/vimcat"
alias mutt="GPG_AGENT_INFO=$HOME/.gnupg/S.gpg-agent mutt"
alias mtop="htop -s M_RESIDENT -u $(whoami)"
alias path="echo $PATH | awk -v RS=: '1'"
if [[ "$HOSTNAME" == "freedom" ]]; then
  alias zzz="systemctl suspend"
  alias hogs="sudo nethogs wlp3s0"
fi
alias mutt-adamkosmin="MUTT_PROFILE=adamkosmin mutt"
alias mutt-nycpatriot="MUTT_PROFILE=nycpatriot mutt"
alias mutt-sailthru="MUTT_PROFILE=sailthru mutt"
alias calcurse-sailthru="calcurse -D ~/.calcurse-sailthru"
alias sf="safe.sh"
alias ssh='TERM=screen-256color ssh'

# git
alias ga='git add'
alias gaa='git add .'
alias gai='git add -i'
alias gc='git commit'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gs='git status -sb'
alias gst='git stash'
alias gl='git log'
alias glg='git log --oneline --all --graph --decorate'
alias gb='git branch'
alias gba='git branch --all'
