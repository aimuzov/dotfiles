function up --description 'Update brew + mise tools, then apply chezmoi'
    argparse g/greedy -- $argv
    or return

    # brew upgrade пропускает каски с auto_updates (Raycast, Spotify, Cursor): brew
    # не видит самообновлений и держит версию момента установки. --greedy-auto-updates
    # тянет их принудительно — гигабайты и закрытые на ходу приложения, отсюда флаг.
    set -l upgrade_flags
    set -q _flag_greedy
    and set upgrade_flags --greedy-auto-updates

    brew update
    and brew upgrade $upgrade_flags
    and brew cleanup
    and mise upgrade --yes
    and chezmoi apply
end
