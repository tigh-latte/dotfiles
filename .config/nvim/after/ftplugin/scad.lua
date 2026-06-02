if vim.g.openscad_job_id then return end

vim.g.openscad_job_id = vim.fn.jobstart({
	"openscad",
	"--viewall",
	"--autocenter",
	vim.api.nvim_buf_get_name(0),
}, {
	on_exit = function()
		vim.g.openscad_job_id = nil
	end
})
