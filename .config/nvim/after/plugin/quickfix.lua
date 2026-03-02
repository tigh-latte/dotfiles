local tigh_latte_group = vim.api.nvim_create_augroup("tigh-latte-quickfix", {})

-- Rebind <C-P> to select the previous item in the quickfix menu, without
-- rebinding it in other buffers.
vim.api.nvim_create_autocmd("BufWinEnter", {
	group = tigh_latte_group,
	pattern = "*quickfix*",
	callback = function()
		if vim.bo.ft == "qf" then
			vim.keymap.set("n", "<C-P>", "k", { buffer = true, remap = false })
			vim.keymap.set("n", "<C-Q>", ":FzfLua quickfix<CR>", { buffer = true, remap = false })
		end
	end,
})

vim.api.nvim_create_autocmd("VimEnter", {
	group = tigh_latte_group,
	callback = function()
		local qf = vim.fn.getqflist({ all = 1 })
		if #qf.items > 0 then
			local gjs = "cfile /tmp/git-jump"
			if qf.title:sub(1, string.len(gjs)) == gjs then
				qf.title = "Git jump"
			end
			vim.fn.setqflist({}, "r", { title = "Git jump" })
			vim.cmd.copen()
			vim.cmd.cfirst()
			vim.cmd("norm! zz")
		end
	end,
})

vim.keymap.set("n", "]q", ":cn<CR>zz")
vim.keymap.set("n", "[q", ":cp<CR>zz")

---@param cmd string?
---@param ... string[]?
local function git_jump(cmd, ...)
	cmd = cmd or "diff"
	vim.system(
		{ "git", "jump", "--stdout", cmd, ... },
		{},
		function(out)
			if out.code ~= 0 then
				vim.notify("failed to run git jump", vim.log.levels.ERROR)
				if out.stderr then
					vim.notify(out.stderr, vim.log.levels.ERROR)
				end
				return
			end

			vim.schedule(function()
				local list = {
					title = ({
						diff = "differences",
						merge = "merge conflicts",
						grep = "grep results",
					})[cmd],
					items = {},
				}
				for _, entry in ipairs(vim.split(out.stdout or "", "\n")) do
					if entry == "" then goto continue end
					local parts = vim.split(entry, ":")

					local bufnr = vim.fn.bufadd(parts[1])
					table.insert(
						list.items,
						{
							bufnr = bufnr,
							filename = parts[1],
							lnum = parts[2],
							col = parts[3],
							text = table.concat({ unpack(parts, 4) }),
						}
					)

					::continue::
				end
				if #list.items == 0 then
					vim.notify("no results", vim.log.levels.ERROR)
					return
				end
				vim.fn.setqflist({}, " ", list)
				vim.cmd.copen()
				vim.cmd.cfirst()
			end)
		end
	)
end

vim.keymap.set("n", "<Leader>gid", git_jump)
vim.keymap.set("n", "<Leader>gim", function() git_jump("merge") end)
vim.keymap.set("n", "<Leader>gii", function()
	vim.ui.input({ prompt = "Git grep > " }, function(input)
		if input and input ~= "" then
			git_jump("grep", input)
		end
	end)
end)
vim.keymap.set("n", "<C-Q><C-F>", ":FzfLua quickfix<CR>")
vim.keymap.set("n", "<C-Q><C-Q>", ":copen<CR>")
