# Dotfiles

TBD...

## First boot

```sh
xcode-select --install & \
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" & \
brew install mise fish & \
brew install --cask keepassxc & \
mise install ubi:twpayne/chezmoi & \
$(mise where ubi:twpayne/chezmoi)/bin/chezmoi init --apply aimuzov
```

## Tools used

- [JankyBorders](https://github.com/FelixKratz/JankyBorders)
- [Karabiner](https://karabiner-elements.pqrs.org)
- [LazyGit](https://github.com/jesseduffield/lazygit)
- [neovim](https://github.com/neovim/neovim)
- [SketchyBar](https://github.com/FelixKratz/SketchyBar)
- [SketchyVim](https://github.com/FelixKratz/SketchyVim)
- [skhd](https://github.com/koekeishiya/skhd)
- [Yabai](https://github.com/koekeishiya/yabai)
- [WezTerm](https://wezfurlong.org/wezterm)

## Useful links

- [macos-defaults.com](https://macos-defaults.com/)

## Repo Activity

![Repo Activity](https://repobeats.axiom.co/api/embed/5f836ec617e98ecfa2c81e02c79aaa806f7bc42e.svg "Repobeats analytics image")
