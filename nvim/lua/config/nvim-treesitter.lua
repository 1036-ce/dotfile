local treesitter = require('nvim-treesitter')

treesitter.setup {
  -- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
  install_dir = vim.fn.stdpath('data') .. '/site'
}

treesitter.install{'c', 'lua', 'vim', 'vimdoc', 'query', 'cpp', 'markdown', 'python'}

vim.api.nvim_create_autocmd('FileType', {
  pattern = {'c', 'lua', 'vim', 'vimdoc', 'query', 'cpp', 'markdown', 'python'},
  callback = function() vim.treesitter.start() end,
})
