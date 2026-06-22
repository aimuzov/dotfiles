function up --description 'Update brew + mise tools, then apply chezmoi'
    brew update
    and brew upgrade
    and brew cleanup
    and mise upgrade --yes
    and chezmoi apply
end
