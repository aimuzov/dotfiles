# vi: ft=fish

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

# -- EDITOR ------------------------------------------------------------------
set -q EDITOR; or set -Ux EDITOR nvim
set -q VISUAL; or set -Ux VISUAL $EDITOR
set -q GIT_EDITOR; or set -Ux GIT_EDITOR $EDITOR

# -- VI MODE -----------------------------------------------------------------
fish_vi_key_bindings

bind -M visual y fish_clipboard_copy
bind -M normal yy fish_clipboard_copy
bind p fish_clipboard_paste

# -- FZF ---------------------------------------------------------------------
if type -q fzf
    fzf --fish | source
    set -gx FZF_DEFAULT_OPTS "--reverse --height 40% --border"
end

# -- PATH --------------------------------------------------------------------
fish_add_path --prepend (path filter $HOME/bin $HOME/.local/bin)
