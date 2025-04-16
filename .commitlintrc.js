const scopes = [
  "asdf",
  "bat",
  "borders",
  "brew",
  "chezmoi",
  "fish",
  "ghostty",
  "git",
  "gitconfig",
  "install-script",
  "karabiner",
  "lazygit",
  "mise",
  "ngrok",
  "nvim",
  "oh-my-posh",
  "other",
  "raycast",
  "shell",
  "sketchybar",
  "skhd",
  "ssh",
  "svim",
  "them-switcher",
  "time",
  "vscode",
  "wezterm",
  "yabai",
  "yazi",
  "zed",
  "zsh",
];

module.exports = {
  allowCustomIssuePrefixs: false,
  allowEmptyIssuePrefixs: false,
  issuePrefixs: [{ value: "Closes" }],
  maxHeaderLength: 100,
  scopes: scopes,
  skipQuestions: ["body", "breaking"],
  useCommitSignGPG: true,
};
