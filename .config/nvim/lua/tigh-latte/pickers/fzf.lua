---@class tigh.picker.BottomOpts
---@field choices string[]
---@field title string
---@field height? number
---@field wrap? boolean
---@field callback fun(choice: string)
---@field preview? fun(choice: string): string?

local M = {}

function M.build_winopts(overrides)
end

---@param opts tigh.picker.BottomOpts
function M.bottom(opts)
	require("fzf-lua").fzf_exec(opts.choices, {
		profile = "ivy",
		actions = {
			default = function(items)
				if #items == 0 then
					return
				end
				return opts.callback(items[1])
			end,
		},
		winopts = {
			height = opts.height and opts.height or 0.4,
			title = " make: ",
			title_pos = "left",
			border = { "", "─", "", "", "", "", "", "" },
			preview = {
				title = opts.title .. ": ",
				title_pos = "right",
				border = function(_, m)
					if m.type == "fzf" then
						return "single"
					else
						assert(m.type == "nvim" and m.name == "prev" and type(m.layout) == "string")
						local b = { "┌", "─", "┐", "│", "┘", "─", "└", "│" }
						if m.layout == "down" then
							b[1] = "├" --top right
							b[3] = "┤" -- top left
						elseif m.layout == "up" then
							b[7] = "├" -- bottom left
							b[6] = "" -- remove bottom
							b[5] = "┤" -- bottom right
						elseif m.layout == "left" then
							b[3] = "┬" -- top right
							b[5] = "┴" -- bottom right
							b[6] = "" -- remove bottom
						else -- right
							b[1] = "┬" -- top left
							b[7] = "┴" -- bottom left
							b[6] = "" -- remove bottom
						end
						return b
					end
				end,
				wrap = opts.wrap ~= nil and opts.wrap or true,
				layout = "horizontal",
				horizontal = "right:50%",
			},
		},
		preview = {
			fn = function(items)
				if opts.preview == nil then
					return
				end
				if #items == 0 then
					return
				end
				return opts.preview(items[1])
			end,
		},
	})
end

return M
