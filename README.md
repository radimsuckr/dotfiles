# Dotfiles
Here are my configuration files for Neovim, Zsh and Git. Feel free to use.

Feel free to inspire or contribute! :)

## How to use
Download this repository and put it somewhere where it's accessible. Recommended location is `~/.dotfiles`.

`git clone git@github.com:Grelek/dotfiles.git ~/.dotfiles`
or
`git clone https://github.com/Grelek/dotfiles.git ~/.dotfiles`

### Neovim
Put and modify following code block in your `~/.nvimrc`.

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

### Git
Run `touch ~/.gitconfig` and put in it following code block.

```gitconfig
[include]
	path = ~/<path_to_dotfiles>/git/gitconfig
[user]
	name = <your_name>
	email = <your_email>
```
