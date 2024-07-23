local open_win = function(config)
	local bufnr = vim.api.nvim_create_buf(false, true) -- 创建一个新的缓冲区
	local win_id = vim.api.nvim_open_win(bufnr, true, {
		relative = 'editor',
		width = config.width,
		height = config.height,
		-- 计算居中位置的行号和列号
		row = math.floor((vim.o.lines - config.height) / 2),
		col = math.floor((vim.o.columns - config.width) / 2),
		style = 'minimal',
		border = 'rounded'
	})
	return bufnr
end



return {
	open_win = open_win
}
