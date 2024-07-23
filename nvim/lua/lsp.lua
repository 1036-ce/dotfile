require('mason').setup({
	ui = {
		--[[ icons = {
		   [     package_installed = "✓",
		   [     package_pending = "➜",
		   [     package_uninstalled = "✗"
		   [ } ]]
	}
})
require('mason-lspconfig').setup({
	-- A list of servers to automatically install if they're not already installed
	ensure_installed = { 'pylsp', 'lua_ls', 'clangd', 'cmake' },
})




-- Set different settings for different languages' LSP
-- LSP list: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
-- How to use setup({}): https://github.com/neovim/nvim-lspconfig/wiki/Understanding-setup-%7B%7D
--     - the settings table is sent to the LSP
--     - on_attach: a lua callback function to run after LSP atteches to a given buffer

local lspconfig = require('lspconfig')

-- Customized on_attach function
-- See `:help vim.diagnostic.*` for documentation on any of the below functions

------------------------------------------------------------- python lsp config
local opts = { noremap = true, silent = true }
-- vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
-- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	-- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	-- local bufopts = { noremap = true, silent = true, buffer = bufnr }
	-- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
	-- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
	-- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
	-- vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
	-- vim.keymap.set('n', '<space>k', vim.lsp.buf.hover, bufopts)
	-- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
	-- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
	-- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
	-- vim.keymap.set('n', '<space>wl', function()
		-- print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	-- end, bufopts)
	-- vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
	-- vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
	-- vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
	-- vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

lspconfig.pylsp.setup({
	on_attach = on_attach,
})

lspconfig.lua_ls.setup({
	on_attach = on_attach,
	settings = {
		Lua = {
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { 'vim', 'require' },
			},
			runtime = {
				-- Tell the language server which version of Lua you're using
				-- (most likely LuaJIT in the case of Neovim)
				version = 'LuaJIT',
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	}
})

lspconfig.clangd.setup({
	on_attach = on_attach,
	cmd = {
		"clangd",
		-- "--clang-tidy",		-- enable clang-tidy
		-- "--clang-tidy-checks=performance-*,bugprone-*",
		"--background-index",
		"--enable-config",
		"--completion-style=detailed",	-- 更详细的补全
		"--all-scopes-completion",		-- 全局补全（会自动补充头文件）
	}
})

lspconfig.cmake.setup({
	on_attach = on_attach,
})

--[[ lspconfig.glslls.setup({
   [     on_attach = on_attach,
   [ }) ]]

vim.diagnostic.config({
	virtual_text = false,
	virtual_lines = false,
	underline = false,
	signs = false,
})

vim.api.nvim_create_user_command("DiagnosticToggle", function()
	local config = vim.diagnostic.config
	local vt = config().virtual_text
	config {
		virtual_text = not vt,
		virtual_lines = not vt,
		underline = not vt,
		signs = not vt, 
	}
end, { desc = "toggle diagnostic" })
