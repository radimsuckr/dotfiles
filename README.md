# Dotfiles
Here are my configuration files. Feel free to use or contribute.

## How to use
Download this repository to `~/.dotfiles`.

`git clone git@github.com:Grelek/dotfiles.git ~/.dotfiles`
or
`git clone https://github.com/Grelek/dotfiles.git ~/.dotfiles`

### Neovim
Put and modify following code block in your `~/.config/nvim/init.vim`.

```viml
so ~/.dotfiles/nvim/nvimrc

" Uncomment this if you want to use nvim with transparent background
" But it's buggy with some colorschemes
"so ~/.dotfiles/nvim/transparent_background

colorscheme <your_choice>
let g:airline_theme='<your_choice>'

" ... another configurations you would like
```

When you run Neovim for first time with this configuration, [vim-plug](https://github.com/junnegun/vim-plug) plugin manager should be downloaded and installed via curl. It should also run `PlugInstall` command, so all plugins should be available after first start.

### Zsh
Just put following code block in your `~/.zshrc`. You also have to download & install [Oh My Zsh!](http://ohmyz.sh).

```zsh
ZSH_CUSTOM=~/.dotfiles/zsh/custom
source ~/.dotfiles/zsh/zshrc

# ... another configurations you would like
```

### X
`ln -s ~/.dotfiles/X/Xresources ~/.Xresources`

`ln -s ~/.dotfiles/X/xinitrc ~/.xinitrc`

### i3
I use [i3-gaps](https://github.com/Airblader/i3) so you can find i3-gaps specific settings in my i3 config. Also instead of i3status I use i3blocks.

`ln -s ~/.dotfiles/i3/config ~/.config/i3/config`

`ln -s ~/.dotfiles/i3/i3blocks/config ~/.i3blocks.conf`

There's also ready i3lock script in `scripts/i3lock-fancy`. View its own readme file for more information.

### Git
Run `touch ~/.gitconfig` and put in it following code block.

```gitconfig
[include]
	path = ~/.dotfiles/git/gitconfig
[user]
	name = <your_name>
	email = <your_email>
```
