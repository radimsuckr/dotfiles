function virtualenv_info {
	[ $VIRTUAL_ENV ] && echo "(`basename $VIRTUAL_ENV`)"
}

function precmd {
	ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[cyan]%}± %{$reset_color%}%{$fg[blue]%}"
	ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
	ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%}!"
	ZSH_THEME_GIT_PROMPT_CLEAN=""
	ZSH_THEME_GIT_PROMPT_SEPARATOR="|"
	ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg[magenta]%}"
	ZSH_THEME_GIT_PROMPT_STAGED="%{$fg[red]%}%{●%G%}"
	ZSH_THEME_GIT_PROMPT_CONFLICTS="%{$fg[red]%}%{✖%G%}"
	ZSH_THEME_GIT_PROMPT_CHANGED="%{$fg[blue]%}%{✚%G%}"
	ZSH_THEME_GIT_PROMPT_BEHIND="%{↓%G%}"
	ZSH_THEME_GIT_PROMPT_AHEAD="%{↑%G%}"
	ZSH_THEME_GIT_PROMPT_UNTRACKED="%{…%G%}"

	PROMPT="%{$fg[red]%}%n%{$reset_color%} %{$fg[cyan]%}${PWD/$HOME/~}%{$reset_color%}`git_prompt_info` %{$reset_color%}"
	RPROMPT="%{$fg[yellow]%}`virtualenv_info`%{$reset_color%}"
}
