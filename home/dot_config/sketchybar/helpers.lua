local M = {}

function M.safe_exec(cmd)
	local handle = io.popen(cmd .. " 2>/dev/null")
	if not handle then
		return nil
	end
	local result = handle:read("a")
	handle:close()
	if not result or result:match("^%s*$") then
		return nil
	end
	return (result:gsub("%s+", ""))
end

function M.wait_for_yabai(max_wait)
	max_wait = max_wait or 10
	local elapsed = 0
	while elapsed < max_wait do
		local handle = io.popen("yabai -m query --spaces 2>/dev/null")
		if handle then
			local result = handle:read("a"):gsub("%s+", "")
			handle:close()
			if result and result:match("^%[") then
				return true
			end
		end
		os.execute("sleep 0.5")
		elapsed = elapsed + 0.5
	end
	return false
end

return M
