require("boot")
require("init")
require("options")
require("keymaps")

if vim.g.vscode then
	return
end

require("hacks")
require("autocmds")

if package.preload["langmapper"] then
	require("langmapper").automapping()
end
