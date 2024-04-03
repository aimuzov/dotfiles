require("boot")
require("init")

if LazyVim.has("langmapper.nvim") then
	require("langmapper").automapping()
end
