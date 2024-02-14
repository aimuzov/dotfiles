require("boot")
require("init")
require("hacks")

if package.preload["langmapper"] then
	require("langmapper").automapping()
end
