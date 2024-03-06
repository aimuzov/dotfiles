require("boot")
require("init")

if package.preload["langmapper"] then
	require("langmapper").automapping()
end
