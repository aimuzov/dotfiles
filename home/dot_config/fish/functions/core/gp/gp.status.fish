function gp.status --description 'List running Palo Alto GlobalProtect processes'
    pgrep -lf 'GlobalProtect|PanGP'; and return 0

    echo "gp.status: not running"
    return 1
end
