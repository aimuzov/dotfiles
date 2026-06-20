function yabai.stack_apps
    # Складывает в один общий стек управляемые окна перечисленных приложений на space.
    # Usage: yabai.stack_apps <space_index> <app>...
    #
    # Работает и с окнами РАЗНЫХ приложений (стек — это про позицию в раскладке, а не
    # про приложение), поэтому, например, Things/Calendar/Mail на одном space можно
    # держать как вкладки одного стека. Со списком из одного приложения сводит в стек
    # его собственные доп. окна (письмо в Mail, вкладка в Dia).
    #
    # Важно: `--stack` тут НЕ годится — он делает стек ровно из двух окон, выдёргивая
    # цель из её текущего стека, поэтому третье окно разваливает стек. Надёжно вносит
    # окно в существующий стек только пара `--insert stack` (пометить точку вставки)
    # + `--warp` (переместить окно в эту область).
    #
    # Из сигнала window_created (yabai задаёт $YABAI_WINDOW_ID) вносится только новое
    # окно — по одному за событие. При ручном вызове (старт yabai) — все окна в первое.
    # Плавающие окна (popover'ы событий, окна настроек) отфильтрованы и не трогаются.

    set -l space_index $argv[1]
    set -l apps $argv[2..-1]

    if test -z "$space_index"
        set space_index (yabai -m query --spaces --space | jq -r '.index')
    end

    test (count $apps) -gt 0; or return

    set -l ids (yabai -m query --windows --space $space_index \
        | jq -r '.[] | select(.["is-floating"]==false) | select(.app as $a | $ARGS.positional | index($a)) | .id' --args $apps)

    test (count $ids) -gt 1; or return

    if set -q YABAI_WINDOW_ID; and contains -- $YABAI_WINDOW_ID $ids
        # Событийный режим: внести новое окно в стек к любому другому окну.
        for id in $ids
            test "$id" = "$YABAI_WINDOW_ID"; and continue
            yabai -m window $id --insert stack
            yabai -m window $YABAI_WINDOW_ID --warp $id
            return
        end
    else
        # Ручной/стартовый режим: собрать все окна в первое.
        for id in $ids[2..-1]
            yabai -m window $ids[1] --insert stack
            yabai -m window $id --warp $ids[1]
        end
    end
end
