function prompt_char {
	git branch >/dev/null 2>/dev/null && echo "%{$fg[cyan]%}±%{$reset_color%}" && return
	echo "%{$fg[cyan]%}\$%{$reset_color%}"
}

function virtualenv_info {
	[ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}

ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[blue]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%}!"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_SEPARATOR="|"
ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg_bold[magenta]%}"
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg[red]%}%{●%G%}"
ZSH_THEME_GIT_PROMPT_CONFLICTS="%{$fg[red]%}%{✖%G%}"
ZSH_THEME_GIT_PROMPT_CHANGED="%{$fg[blue]%}%{✚%G%}"
ZSH_THEME_GIT_PROMPT_BEHIND="%{↓%G%}"
ZSH_THEME_GIT_PROMPT_AHEAD="%{↑%G%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{…%G%}"

function precmd {
	PROMPT="%{$fg[magenta]%}%n%{$reset_color%} %{$fg[white]%}@%{$reset_color%} %{$fg[red]%}%m%{$reset_color%} %{$fg_bold[green]%}${PWD/$HOME/~}%{$reset_color%}$(git_prompt_info) $(prompt_char) %{$reset_color%}"
	RPROMPT="%{$fg[yellow]%}$(virtualenv_info)%{$reset_color%}"
}
