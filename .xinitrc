xrdb -merge .Xresources

xsetroot -cursor_name left_ptr

if type feh &> /dev/null && [ -e $HOME/.fehbg ]; then
  source "$HOME/.fehbg"
fi

if type VBoxClient &> /dev/null; then
  VBoxClient --clipboard
  VBoxClient --display
fi

exec ck-launch-session xmonad
