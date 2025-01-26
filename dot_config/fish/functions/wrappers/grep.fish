function grep --description 'alias grep command with filter' --wraps grep
    command grep --exclude-dir={.git,node_modules} $argv
end
