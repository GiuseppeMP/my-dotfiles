# create .config
mkdir -p ~/.config
mkdir -p ~/.i3

# Install links
ln -sf ~/.dotfiles/zsh/.zshrc ~/.zshrc
ln -sf ~/.dotfiles/starship/starship.toml ~/.config/starship.toml
ln -sf ~/.dotfiles/kitty ~/.config/kitty
ln -sf ~/.dotfiles/nvim ~/.config/nvim
ln -sf ~/.dotfiles/.i3/config ~/.i3/config
ln -sf ~/.dotfiles/picom/picom.conf ~/.config/picom.conf
ln -sf ~/.dotfiles/asdf/asdfrc ~/.asdfrc
ln -sf ~/.dotfiles/kmonad/config.kbd ~/.config/kmonad/config.kbd
