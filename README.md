# Dotfiles
Here are my configuration files for Neovim, Zsh and Git. Feel free to use.

Feel free to inspire or contribute! :)

## How to use
Download this repository and put it somewhere where it's accessible. Recommended location is `~/.dotfiles`.

`git clone git@github.com:Grelek/dotfiles.git ~/.dotfiles`
or
`git clone https://github.com/Grelek/dotfiles.git ~/.dotfiles`

### Neovim
Put and modify following code block in your `~/.config/nvim/init.vim`.

```viml
so ~/<path_to_dotfiles>/nvim/nvimrc

" Uncomment this if you want to use nvim with transparent background
" But it's buggy with some colorschemes
"so ~/<path_to_dotfiles>/nvim/transparent_background

colorscheme <your_choice>
let g:airline_theme='<your_choice>'

" ... another configurations you would like
```

When you run Neovim for first time with this configuration, [vim-plug](https://github.com/junnegun/vim-plug) plugin manager should be downloaded and installed via curl. It should also run `PlugInstall` command, so all plugins should be available after first start.

### Zsh
Just put following code block in your `~/.zshrc`. You also have to download & install [Oh My Zsh!](http://ohmyz.sh).

```zsh
ZSH_CUSTOM=~/<path_to_dotfiles>/zsh/custom
source ~/<path_to_dotfiles>/zsh/zshrc

# ... another configurations you would like
```

### i3
I use [i3-gaps](https://github.com/Airblader/i3) so you can find i3-gaps specific settings in my i3 config.

`ln -s ~/<path_to_dotfiles>/i3/config ~/.config/i3/config`

Also don't forget to use [i3lock-fancy](https://github.com/Grelek/i3lock-fancy) instead of i3lock.

The only thing you need to do is clone i3lock-fancy in `~/bin/i3lock-fancy` or somewhere else on your `PATH` (don't forget to change the path to i3lock-fancy in `i3/config`).

### Git
Run `touch ~/.gitconfig` and put in it following code block.

```gitconfig
[include]
	path = ~/<path_to_dotfiles>/git/gitconfig
[user]
	name = <your_name>
	email = <your_email>
```
