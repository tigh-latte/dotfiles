hs.window.animationDuration = 0
local grid = hs.grid.setGrid('6x1').getGrid()

local function set(pos, w)
	return function(cell)
		local cells = grid.w * w
		cell.x = (grid.w - cells) * pos
		cell.y = 0
		cell.w = cells
		cell.h = grid.h
	end
end

hs.hotkey.bind({ CTRL, SUPER }, "W", function()
	hs.grid.adjustWindow(set(0, 2 / 3))
end)

hs.hotkey.bind({ CTRL, SUPER }, "E", function()
	hs.grid.adjustWindow(set(0.5, 2 / 3))
end)

hs.hotkey.bind({ CTRL, SUPER }, "R", function()
	hs.grid.adjustWindow(set(1, 2 / 3))
end)

hs.hotkey.bind({ CTRL, SUPER }, "S", function()
	hs.grid.adjustWindow(set(0, 1 / 3))
end)

hs.hotkey.bind({ CTRL, SUPER }, "D", function()
	hs.grid.adjustWindow(set(0.5, 1 / 3))
end)

hs.hotkey.bind({ CTRL, SUPER }, "F", function()
	hs.grid.adjustWindow(set(1, 1 / 3))
end)
