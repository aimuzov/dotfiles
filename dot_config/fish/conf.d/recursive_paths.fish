for scope in functions completions
    set -l root "$__fish_config_dir/$scope"

    if test -d $root
        set -l subdirs (find $root -type d ! -path $root -print0 | string split0 | path resolve)

        if test (count $subdirs) -gt 0
            switch $scope
                case functions
                    set fish_function_path $subdirs $fish_function_path
                case completions
                    set fish_complete_path $subdirs $fish_complete_path
            end
        end
    end
end
