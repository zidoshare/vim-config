plugins=(
	git
	docker
  zsh-syntax-highlighting
  zsh-autosuggestions
  autojump
  fzf-zsh-plugin
  zfm
)

alias ls='lsd'
export EDITOR="vim"
export VISUAL="vim"

lg()
{
    export LAZYGIT_NEW_DIR_FILE=~/.lazygit/newdir

    lazygit "$@"

    if [ -f $LAZYGIT_NEW_DIR_FILE ]; then
            cd "$(cat $LAZYGIT_NEW_DIR_FILE)"
            rm -f $LAZYGIT_NEW_DIR_FILE > /dev/null
    fi
}
export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'
export FZF_COMPLETION_TRIGGER='\'
export FZF_PREVIEW_ADVANCED=true
export FZF_DEFAULT_OPTS='--bind=ctrl-k:up,ctrl-j:down'
export MANPAGER="col -b | vim -MR - "
