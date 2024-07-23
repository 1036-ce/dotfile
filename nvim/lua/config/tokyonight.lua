require("tokyonight").setup({
	style = "storm",
	-- disable italic for functions
	styles = {
		functions = {}
	},
	sidebars = { "qf", "vista_kind", "terminal", "packer" },
	-- Change the "hint" color to the "orange" color, and make the "error" color bright red
	on_colors = function(colors)
		colors.hint = colors.orange
		colors.error = "#ff0000"
		colors.comment = "#b39396"
	end
})

local colorscheme = 'tokyonight-storm'
local is_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not is_ok then
	vim.notify('colorscheme ' .. colorscheme .. ' not found!')
end

