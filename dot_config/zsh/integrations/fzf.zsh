# https://github.com/catppuccin/fzf?tab=readme-ov-file#usage
export FZF_DEFAULT_OPTS=$([[ $MACOS_IS_DARK == "yes" ]] && echo " \
--color=bg+:#363a4f,bg:-1,spinner:#f4dbd6,hl:#ed8796 \
--color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
--color=marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796" || echo " \
--color=bg+:#ccd0da,bg:-1,spinner:#dc8a78,hl:#d20f39 \
--color=fg:#4c4f69,header:#d20f39,info:#8839ef,pointer:#dc8a78 \
--color=marker:#dc8a78,fg+:#4c4f69,prompt:#8839ef,hl+:#d20f39")

FZF_DEFAULT_OPTS+=" \
--reverse \
--height '90%' \
"

export FZF_DEFAULT_COMMAND="fd --type f --strip-cwd-prefix --hidden --follow"

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export FZF_CTRL_T_OPTS="
	--preview 'bat -n --color=always {}'
	--bind 'ctrl-/:change-preview-window(hidden|)'
"

## ---------------------------------------------------------------------------------------------------------------------

# https://github.com/junegunn/fzf?tab=readme-ov-file#setting-up-shell-integration
source <($(mise which fzf) --zsh)
