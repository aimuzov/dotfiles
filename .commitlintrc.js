const scopes = [
  "borders",
  "brew",
  "chezmoi",
  "git",
  "gitconfig",
  "karabiner",
  "lazygit",
  "nvim",
  "other",
  "shell",
  "sketchybar",
  "skhd",
  "spaceship",
  "svim",
  "wezterm",
  "yabai",
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
