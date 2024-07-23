local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("config.tokyonight")
		end
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {} -- this is equalent to setup({}) function
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
	},
	{
		"hrsh7th/nvim-cmp",
		lazy = true,
		-- load cmp on InsertEnter
		event = "InsertEnter",
		-- these dependencies will only be loaded when cmp loads
		-- dependencies are always lazy-loaded unless specified otherwise
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},

		config = function()
			require("config.nvim-cmp")
		end 
	},
	{
		"L3MON4D3/LuaSnip",
		lazy = true,
		event = "InsertEnter",
		-- follow latest release.
		version = "2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- install jsregexp (optional!).
		build = "make install_jsregexp",
		-- dependencies = { "rafamadriz/friendly-snippets" },
		config = function()
			require("config.LuaSnip")
		end
	},
	{
		"williamboman/mason.nvim",
		lazy = false,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
	},
	{
		"nvim-lualine/lualine.nvim",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons"
		},
		config = function()
			require("config.lualine")
		end
	},
	{
		'akinsho/bufferline.nvim',
		lazy = false,
		-- version = "*",
		dependencies = 'nvim-tree/nvim-web-devicons',
		config = function()
			require("config.bufferline")
		end
	}, 
	{
		"nvim-tree/nvim-tree.lua",
		lazy = true,
		cmd = {
			"NvimTreeToggle"
		},
		keys = {
			{ '<leader>fm', "<Cmd>NvimTreeToggle<CR>", mode = 'n', desc = "Nvim Tree" },
		},
		config = function()
			require("config.nvim-tree")
		end,
	},
	{
		"preservim/nerdcommenter",
		lazy = true,
		event = "BufEnter",
		config = function()
			vim.g.NERDCompactSexyComs = 1,
			vim.cmd("let g:NERDDefaultAlign = 'left' ")
			-- vim.g.NERDDefaultAlign = {left}
			vim.g.NERDSpaceDelims = 1
		end
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
		lazy = false,
		config = function()
			require("config.indent-blankline")
		end  
	}, 
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		config = function()
			require("config.nvim-treesitter")
		end
	},
	{
		"akinsho/toggleterm.nvim",
		lazy = true,
		cmd = {
			"ToggleTerm"
		},
		version = "*",
		config = true,
	},
	--[[ {
	   [     "folke/which-key.nvim",
	   [     event = "VeryLazy",
	   [     init = function()
	   [         vim.o.timeout = true
	   [         vim.o.timeoutlen = 800
	   [     end,
	   [     opts = {
	   [         -- your configuration comes here
	   [         -- or leave it empty to use the default settings
	   [         -- refer to the configuration section below
	   [     }
	   [ }, ]]
	{
		"romainl/vim-cool",
		lazy = true,
		event = { "CursorMoved", "InsertEnter" },
	},
	{
		"nvimdev/lspsaga.nvim",
		-- event = "LspAttach",
		config = function()
			require("config.lspsaga")
		end, 
		dependencies = {
			{"nvim-tree/nvim-web-devicons"},
			--Please make sure you install markdown and markdown_inline parser
			{"nvim-treesitter/nvim-treesitter"}
		}
	},
	{
		"nvim-tree/nvim-web-devicons",
		lazy = false,
		config = function()
			require("config.nvim-web-devicons")
		end
	},
	{
		'nvim-telescope/telescope.nvim', tag = '0.1.2',
		lazy = true,
		cmd = {
			"Telescope"
		},
		-- or                              , branch = '0.1.x',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},
	{
		"ray-x/lsp_signature.nvim",
		lazy = false,
		-- event = "LspAttach",
		config = function()
			require("config.lsp_signature")
		end
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end
	},
	{
		"junegunn/vim-easy-align",
		lazy = true,
		event = "BufEnter",
		config = function()
			vim.cmd("xnoremap ga <Plug>(EasyAlign)");
			vim.cmd("nnoremap ga <Plug>(EasyAlign)");
		end
	},
--[[     {
   [         "folke/noice.nvim",
   [         event = "VeryLazy",
   [         opts = {
   [             -- add any options here
   [         },
   [         dependencies = {
   [             -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
   [             "MunifTanjim/nui.nvim",
   [             -- OPTIONAL:
   [             --   `nvim-notify` is only needed, if you want to use the notification view.
   [             --   If not available, we use `mini` as the fallback
   [             "rcarriga/nvim-notify",
   [         },
   [         config = function()
   [             require("config.noice")
   [         end
   [     }, 
   [     {
   [ 
   [         "rcarriga/nvim-notify",
   [         event = "VeryLazy",
   [         opts = {
   [             -- add any options here
   [         },
   [     }, ]]
	{
		"RRethy/vim-illuminate",
		lazy = false,
		config = function()
			require("config.vim-illuminate");
		end
	}, 
	{
		"tikhomirov/vim-glsl",
		lazy = false,
		ft = "glsl"
	},
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function() vim.fn["mkdp#util#install"]() end,
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		lazy = true,
		cmd = {"Harpoon"},
		requires = { {"nvim-lua/plenary.nvim"} },
		config = function()
			require("config.harpoon")
		end
	},
	{
		'stevearc/aerial.nvim',
		opts = {},
		-- Optional dependencies
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons"
		},
		config = function()
			require("config.aerial")
		end
	},
	{
		"OXY2DEV/markview.nvim",
		ft = "markdown",

		dependencies = {
			-- You may not need this if you don't lazy load
			-- Or if the parsers are in your $RUNTIMEPATH
			"nvim-treesitter/nvim-treesitter",

			"nvim-tree/nvim-web-devicons"
		},
		config = function()
			require('config.markview')
		end
	}
},
{})
