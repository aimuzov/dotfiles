return {
	setup = function()
		local old_build = Tab.build

		Tab.build = function(self, ...)
			local chunks = self._chunks

			self._chunks = {
				chunks[1]:pad(ui.Pad(1, 0, 0, 0)),
				chunks[2]:pad(ui.Pad(1, 0, 0, 0)),
				chunks[3]:pad(ui.Pad(1, 0, 0, 0)),
			}

			self._base = ya.list_merge(self._base or {}, {
				ui.Border(ui.Edge.TOP):area(self._area):type(ui.Border.PLAIN):style(th.mgr.border_style),
				ui.Bar(ui.Edge.TOP)
					:area(ui.Rect({
						x = chunks[1].right - 1,
						y = chunks[1].y,
						w = ya.clamp(0, self._area.w - chunks[2].right - 1, 1),
						h = self._area.h,
					}))
					:symbol("┬"),
				ui.Bar(ui.Edge.TOP)
					:area(ui.Rect({
						x = chunks[2].right,
						y = chunks[2].y,
						w = ya.clamp(0, self._area.w - chunks[2].right, 1),
						h = self._area.h,
					}))
					:symbol("┬"),
			})

			old_build(self, ...)
		end
	end,
}
