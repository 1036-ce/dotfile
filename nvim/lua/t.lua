local utils = require('utils')

vim.api.nvim_create_user_command('Test',
function()
	utils.open_win({
		width = 20,
		height = 20,
	})
end,
{nargs=0}
)

