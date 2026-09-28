function vps-direct --description 'Прямой маршрут до серверов aleshavpnov мимо туннеля VPN'
    # Happ в режиме TUN забирает весь трафик, и выкат образа до мастера шёл через ноду
    # на ~230 КБ/с. Маршрут до конкретного хоста главнее маршрута по умолчанию, поэтому
    # серверам хватает host-маршрутов через шлюз физической сети. -d убирает их обратно.
    argparse d/delete -- $argv
    or return

    set -l ips (string match -r '^\s*(\d+\.\d+\.\d+\.\d+)\s+aleshavpnov-vps-' -g < /etc/hosts | sort -u)
    if test (count $ips) -eq 0
        echo 'в /etc/hosts нет строк aleshavpnov-vps-*' >&2
        return 1
    end

    if set -q _flag_delete
        for ip in $ips
            sudo route -n delete -host $ip >/dev/null
        end
        echo "маршруты убраны: $ips"
        return 0
    end

    # Шлюз физической сети: маршрут по умолчанию не через utun.
    set -l gw (netstat -rn -f inet | awk '$1 == "default" && $NF !~ /^(utun|bridge)/ && $2 ~ /^[0-9.]+$/ { print $2; exit }')
    if test -z "$gw"
        echo 'не нашёл шлюз физической сети' >&2
        return 1
    end

    for ip in $ips
        sudo route -n delete -host $ip >/dev/null 2>&1
        sudo route -n add -host $ip $gw >/dev/null
        or return
    end
    echo "через $gw: $ips"
end
