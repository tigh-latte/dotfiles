return {
	"vim-airline/vim-airline",
	config = function()
		vim.cmd([[
    "let g:airline#extensions#tabline#enabled = 1
    "let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
    let g:airline#extensions#whitespace#symbol = '!'
    let g:airline_mode_map = {
      \ '__': '-',
      \ 'n': 'N',
      \ 'i': 'I',
      \ 'ic': 'IC',
      \ 'R': 'R',
      \ 'c': 'C',
      \ 'v': 'V',
      \ 'V': 'V-LINE',
      \ '': 'V-BLOCK',
      \ 's': 'S',
      \ 'S': 'S'
      \ }
]])
	end,
}
