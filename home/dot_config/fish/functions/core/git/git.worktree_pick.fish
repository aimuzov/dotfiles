function git.worktree_pick -d "cd into a git worktree picked with fzf"
    set -l dir (git worktree list 2>/dev/null \
        | fzf --prompt="Worktrees > " --height=~50% --layout=reverse --border --exit-0 --select-1 \
            --query "$argv" --preview 'git -C {1} log --oneline --color=always -10' \
        | string split -f1 ' ')

    test -n "$dir"; and cd $dir
end
