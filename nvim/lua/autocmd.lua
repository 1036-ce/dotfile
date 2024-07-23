-- 进入终端后直接进入insert mode
-- vim.cmd("autocmd TermOpen * startinsert")
-- vim.cmd("autocmd! TermEnter * startinsert")
vim.cmd("autocmd BufWinEnter,WinEnter term://* startinsert")
vim.cmd("autocmd FileType python setlocal noexpandtab")

vim.cmd("au BufRead,BufNewFile *.vert set filetype=glsl")
vim.cmd("au BufRead,BufNewFile *.frag set filetype=glsl")
vim.cmd("au BufRead,BufNewFile *.tesc set filetype=glsl")
vim.cmd("au BufRead,BufNewFile *.tese set filetype=glsl")
vim.cmd("au BufRead,BufNewFile *.geom set filetype=glsl")
vim.cmd("au BufRead,BufNewFile *.comp set filetype=glsl")


