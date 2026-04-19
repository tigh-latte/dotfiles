vim.lsp.config("tsgo", {
	filetypes = {
		"javascript", "javascriptreact", "javascript.jsx",
		"typescript", "typescriptreact", "typescript.tsx",
	},
	root_dir = function(bufnr, on_dir)
		local root = vim.fs.root(bufnr, { ".git" })
		on_dir(root or vim.fn.getcwd())
	end,
	single_file_support = true,
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id) or {}
		if client.name ~= "tsgo" then return end

		for name, value in pairs(client.server_capabilities) do
			if value == true and name ~= "diagnosticProvider" then
				client.server_capabilities[name] = false
			end
		end
	end
})

vim.lsp.enable('tsgo', true)
