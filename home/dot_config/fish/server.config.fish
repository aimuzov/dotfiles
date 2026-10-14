# vi: ft=fish

# config.fish of a Linux server (the projects server): config.fish.tmpl
# takes this file instead of the Mac config. Vi mode and the subfolders of
# functions/ come from conf.d, as on the Mac.

# -- XDG ---------------------------------------------------------------------
set -q XDG_CONFIG_HOME; or set -Ux XDG_CONFIG_HOME $HOME/.config
set -q XDG_DATA_HOME; or set -Ux XDG_DATA_HOME $HOME/.local/share
set -q XDG_STATE_HOME; or set -Ux XDG_STATE_HOME $HOME/.local/state
set -q XDG_CACHE_HOME; or set -Ux XDG_CACHE_HOME $HOME/.cache

for d in $XDG_CONFIG_HOME $XDG_DATA_HOME $XDG_STATE_HOME $XDG_CACHE_HOME
    test -d $d; or mkdir -p $d
end

# -- GREETING ----------------------------------------------------------------
set fish_greeting

# -- COLORSCHEME -------------------------------------------------------------
fish_config theme choose catppuccin-macchiato

# -- PROMPT ------------------------------------------------------------------
if type -q oh-my-posh
    oh-my-posh init fish --config $XDG_CONFIG_HOME/oh-my-posh/config.json | source
end

# -- EDITOR ------------------------------------------------------------------
if set -l editors (command -s nvim vim vi)
    set -q EDITOR; or set -Ux EDITOR $editors[1]
    set -q VISUAL; or set -Ux VISUAL $EDITOR
    set -q GIT_EDITOR; or set -Ux GIT_EDITOR $EDITOR
end

# -- CLIPBOARD ---------------------------------------------------------------
bind -M visual y fish_clipboard_copy
bind -M normal yy fish_clipboard_copy
bind p fish_clipboard_paste

# -- ZOXIDE ------------------------------------------------------------------
if type -q zoxide
    zoxide init fish | source
end

# -- FZF ---------------------------------------------------------------------
# The fzf.fish key bindings and the catppuccin colors, as on the Mac.
if type -q fzf
    source $__fish_config_dir/conf.d/fzf/fzf.fish
    source $__fish_config_dir/themes/catppuccin-fzf-macchiato.fish
    set -gx FZF_DEFAULT_OPTS "$FZF_DEFAULT_OPTS --reverse --height 40% --border"
end

# -- PATH --------------------------------------------------------------------
fish_add_path --prepend (path filter $HOME/bin $HOME/.local/bin)
