cd ~/.config/kitty
rm ~/.config/kitty/theme.conf
ln -s ./kitty-themes/themes/Solarized_Light.conf ~/.config/kitty/theme.conf
rm ~/.tmux.theme.conf
ln -s ./.tmux.theme.light.conf ~/.tmux.theme.conf
tmux source-file ~/.tmux.conf
kitty @ set-colors --all --configured ~/.config/kitty/kitty.conf
