local function file_in(directory)
  local filepath = vim.fn.expand("%:p")
  if filepath == "" then
    return false
  end

  return string.find(filepath, directory) ~= nil
end

vim.opt.clipboard = 'unnamedplus'	-- use system clipboard
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.writebackup = false
vim.opt.undofile = false
vim.opt.hidden = true
vim.opt.foldcolumn = "0"
vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 10
vim.opt.foldenable = true
vim.opt.virtualedit = "block"
-- vim.g.python_recommanded_style = 0
-- set foldcolumn=0
-- set foldmethod=indent
-- set foldlevel=10
-- set foldenable  "允许折叠

-- vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }		-- ???
vim.opt.mouse = 'a'					-- allow the mouse

-- Tab
if file_in("postgresql") then
  vim.opt.cinoptions="(0"
  vim.opt.tabstop = 4
  vim.opt.shiftwidth = 4
else
  vim.opt.expandtab = true	-- do not change tab to spaces
  vim.opt.smartindent = true
  vim.opt.tabstop = 2
  vim.opt.softtabstop = 2
  vim.opt.shiftwidth = 2
end


-- UI config 
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true		-- highlight cursor line
vim.opt.termguicolors = true	-- enable 24-bit color
vim.opt.showmode = true			-- show current mode


-- Search
vim.opt.incsearch = true	-- search as characters are entered
vim.opt.hlsearch = true		-- do not highlight matches
vim.opt.ignorecase = true	-- ignore case in searches by default
vim.opt.smartcase = true	-- but make it case sensitive if an uppercase is entered

-- inlay hint
vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())

