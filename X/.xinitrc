export DISPLAY=:0.0
[[ -r ~/.Xresources ]] && xrdb -merge ~/.Xresources

# disable bell
xset -b

# DPMS (Engergy Star) turns off the screen in 10 minutes
xset dpms 600

# no screen saver
xset s off

# kill X with ctrl+alt+del
setxkbmap -option terminate:ctrl_alt_bksp

# enforce correct locales from the beginning
unset LC_ALL
export LANG=en_US.UTF-8
export LC_MESSAGES=C
export LC_TIME=en_US.UTF-8

# set background color
xsetroot -solid #222222

# setup the rodent
xsetroot -cursor_name left_ptr

# keyboard rate
xset r rate 200 40

# fonts
# xset +fp /usr/share/fonts/misc
# xset fp rehash

exec i3 -V > /tmp/i3.log 2>&1
