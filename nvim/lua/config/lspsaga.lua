require("lspsaga").setup({
	symbol_in_winbar = {
		enable = true,
	}, 
	-- disable lightbulb
	lightbulb = {
		enable = false,
	},
	preview = {
		lines_above = 1,
		lines_below = 17,
	},
	finder = {
		max_height = 0.5,
		min_width = 30,
		force_max_height = false,
		keys = {
			jump_to = 'p',
			expand_or_jump = '<CR>',
			vsplit = 's',
			split = 'i',
			tabe = 't',
			tabnew = 'r',
			quit = { 'q', '<ESC>' },
			close_in_preview = '<ESC>',
		},
	},
	definition = {
		edit = "<C-c>o",
		vsplit = "<C-c>v",
		split = "<C-c>s",
		tabe = "<C-c>t",
		quit = "q",
	},
	code_action = {
		num_shortcut = true,
		keys = {
			quit = "q",
			exec = "<CR>",
		},
	},
	outline = {
		win_position = "right",
		win_with = "",
		win_width = 30,
		preview_width= 0.4,
		show_detail = true,
		auto_preview = true,
		auto_refresh = true,
		auto_close = true,
		auto_resize = false,
		custom_sort = nil,
		keys = {
			expand_or_jump = '<CR>',
			quit = "q",
		},
	},
	rename = {
		quit = "<Esc>",
		exec = "<CR>",
		mark = "x",
		confirm = "<CR>",
		in_select = false,
	},
	beacon = {
		enable = true,
		frequency = 7,
	},
	ui = {
		title = false,
		border = "rounded", -- Can be single, double, rounded, solid, shadow.
		winblend = 0,
	},
})
