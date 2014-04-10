xrdb -merge .Xresources

xsetroot -cursor_name left_ptr

if [ -e /usr/bin/feh ] && [ -e $HOME/.fehbg ]
	then source "$HOME/.fehbg"
	#then feh --bg-max "`find "/home/hinidu/photo" -type f -name "*.jpg" | shuf -n 1`"
fi

exec ck-launch-session xmonad
