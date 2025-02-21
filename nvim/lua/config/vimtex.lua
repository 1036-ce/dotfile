vim.g.maplocalleader = ' '
vim.g.vimtex_compiler_method = 'latexmk'
vim.g.vimtex_compiler_latexmk = {
  executable = 'latexmk',
  options = {
    '-file-line-error',
    '-synctex=1',
    '-interaction=nonstopmode'
  },
  aux_dir = "./aux",
  out_dir = "./out"
}
vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_view_zathura_sync = 1
vim.g.vimtex_view_zathura_activate = 1
vim.g.vimtex_view_zathura_reading_bar = 1
