vim.cmd([[
    augroup TerminalHelpers
        autocmd!
        autocmd BufEnter * if &buftype == 'terminal' | :startinsert | endif
        autocmd TermOpen * setlocal nonumber
        autocmd TermClose * execute 'bdelete! ' . expand('<abuf>')
    augroup END
]])
