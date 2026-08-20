-- Require order is bar order. Everything but datetime and battery comes from vendor/,
-- the sketchybar-items repository: those items check their own tools and return false
-- when one is missing, so a machine without yabai gets a shorter bar, not an error.
require("items.yabai_spaces")
require("items.skhd_mode")
require("items.yabai_window")

require("items.right.datetime")

require("items.caffeinate")
require("items.tailscale")

require("items.right.battery")
require("items.input")
