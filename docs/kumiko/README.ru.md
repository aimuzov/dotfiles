# Конфигурация kumiko

> 🇺🇸 [English version](README.md)

kumiko это собственный тайловый менеджер окон для macOS в виде одного приложения. В нём есть
виртуальные рабочие пространства без отключения SIP, горячие клавиши с режимами, панель
состояния, рамки окон и vim-режимы в текстовых полях. В этом репозитории он заменил yabai, skhd, JankyBorders,
SketchyBar и SketchyVim.

Приложение пока не опубликовано и собирается из своего репозитория: `scripts/bundle.sh` кладёт
`dist/Kumiko.app`, а CLI `kumiko` лежит внутри бандла в `Kumiko.app/Contents/MacOS/kumiko`.
Поэтому его нет в Brewfile.

## Файлы

| Исходник | Куда попадает |
| --- | --- |
| `home/dot_config/kumiko/kumiko.toml` | `~/.config/kumiko/kumiko.toml` |
| `home/dot_bin/raycast/executable_restart-vm.sh` | Команда Raycast `Restart WM` |

kumiko следит за файлом конфига и перечитывает его при изменении, так что хватает
`chezmoi apply`. Со сломанным файлом остаётся в силе прежний конфиг, а ошибка видна в меню
приложения и в `kumiko status`.

## Секции конфига

- `[wm]` и `[[wm.rule]]`: отступы, какие приложения раскладываются тайлами и есть ли у их окон
  тени (перенесено из yabairc)
- `[[workspace]]`: именованные рабочие пространства, их дисплей (`external` или `builtin`)
  и приложения; порядок совпадает с порядком хоткеев `alt - 1` … `alt - =`
- `[hotkeys]`: привязки и режимы (перенесено из skhdrc)
- `[borders]`: толщина, скругление, цвет рамок и исключения (перенесено из bordersrc)
- `[vim]`: vim-режимы в текстовых полях с русским `langmap` (перенесено из svimrc)
- `[menubar]`: прячет статус-иконки меню-бара за шеврон, как Ice; здесь он заменил Ice

## Тени окон

`shadows = false` работает через scripting addition, который kumiko загружает в Dock, как это
делал yabai. Для него нужен root:

```bash
sudo kumiko sa install   # копирует payload из Kumiko.app
kumiko sa status         # установлен ли, загружен ли и какой версии
```

Чтобы приложение загружало его без пароля после перезапуска Dock, строку из `kumiko sa sudoers`
нужно положить в `/private/etc/sudoers.d/kumiko`. Строка привязана к хешу бинарника, поэтому после
каждой пересборки устаревает.

## Горячие клавиши

| Клавиши | Действие |
| --- | --- |
| `alt - 1` … `alt - =` | Перейти на рабочее пространство 1–12 |
| `alt - h/j/k/l` | Фокус на окно слева/снизу/сверху/справа |
| `cmd + ctrl - i` | Режим окна: фокус, стопки, float, зум, размер, закрыть, выровнять |
| `cmd + ctrl - m` | Режим перемещения: перенос окон, поворот и отражение раскладки |
| `cmd + ctrl - n` | Режим изменения размера |
| `cmd + ctrl - o` | Режим стопок |
| `cmd + ctrl - ;` | Командный режим: `w` перечитывает конфиг, `l` гасит дисплей |
| `escape` или `ctrl - [` | Назад в обычный режим |

Полный список есть в самом `kumiko.toml`.

## CLI

```bash
kumiko ping                  # запущено ли приложение
kumiko status                # модули, разрешения, путь к конфигу, последняя ошибка
kumiko reload                # перечитать kumiko.toml
kumiko settings              # открыть окно настроек (только чтение)
kumiko query workspaces      # состояние в JSON: windows | focused | workspaces | displays
kumiko workspace focus Code  # по имени или номеру
kumiko menubar toggle        # показать или спрятать иконки левее разделителя
kumiko quit                  # выйти, вернув скрытые окна на экран
```

## Перезапуск

Команда Raycast `Restart WM` находит `Kumiko.app` по bundle id `online.aimuzov.kumiko`, вызывает
`kumiko quit` и снова открывает приложение.
