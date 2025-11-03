vim.keymap.set("n", "<Leader>ma", function()
	local fname = "Makefile"
	if not vim.uv.fs_stat(fname) then
		return
	end

	local bufnr = vim.fn.bufadd(fname)
	if not vim.api.nvim_buf_is_loaded(bufnr) then
		vim.fn.bufload(bufnr)
	end

	local parser = vim.treesitter.get_parser(bufnr)
	if not parser then
		return
	end
	local root = parser:parse()[1]:root()

	local query = vim.treesitter.query.parse(
		"make",
		[[
		(rule
			(targets) @__target
		) @__rule
	]]
	)

	local targets, rules = {}, {}
	local rule
	for id, node in query:iter_captures(root, bufnr) do
		local capture = query.captures[id]
		assert(({ __target = "", __rule = "" })[capture], "unrecognised capture")
		local line, char, eline, echar = node:range()

		if query.captures[id] == "__target" then
			local text = table.concat(vim.api.nvim_buf_get_text(bufnr, line, char, eline, echar, {}), "\n")
			table.insert(targets, text)
			rules[text] = rule
		elseif query.captures[id] == "__rule" then
			rule = table.concat(vim.api.nvim_buf_get_lines(bufnr, line, eline, false), "\n")
		end
	end

	if #targets == 0 then
		return
	end

	-- vim.ui.select(targets, { prompt = "make:" }, function(item, idx)
	-- 	if not idx then return end
	-- 	vim.system({ "make", item }, {}, function(out)
	-- 		print(out.stdout, "\n", out.stderr)
	-- 	end)
	-- end)

	require("tigh-latte.pickers.fzf").bottom({
		choices = targets,
		callback = function(item)
			vim.system({ "make", item }, {}, function(out)
				print(out.stdout, "\n", out.stderr)
			end)
		end,
		title = "make",
		height = 0.2,
		preview = function(item)
			return rules[item]
		end,
	})
end, {})
