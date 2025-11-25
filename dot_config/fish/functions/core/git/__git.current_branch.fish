function __git.current_branch -d "Output git's current branch name"
    git branch --show-current 2>/dev/null; or git rev-parse --short HEAD 2>/dev/null; or return
end
