local old_manager_render = Manager.render

function Manager:render(area)
	return old_manager_render(self, ui.Rect({ x = area.x, y = area.y - 1, w = area.w, h = area.h + 2 }))
end

function Status:render()
	return {}
end

function Header:render(area)
	return {}
end
