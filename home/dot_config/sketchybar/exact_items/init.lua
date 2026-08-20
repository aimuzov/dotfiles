-- Require order is bar order. Every item comes from vendor/, the sketchybar-items
-- repository: they check their own tools and return false when one is missing, so a
-- machine without yabai gets a shorter bar, not an error. Nothing of the bar itself
-- is there — the height, the palette and this order are what stay here.
require("items.yabai_spaces")
require("items.skhd_mode")
require("items.yabai_window")

require("items.datetime")

require("items.caffeinate")
require("items.tailscale")

require("items.battery")
require("items.input")
