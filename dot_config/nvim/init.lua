require("config.lazy.init")

if LazyVim.has("langmapper.nvim") then
	require("langmapper").automapping()
end
