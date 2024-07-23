Data = {
	is_proj = false,
	root_path = ""
}


Check = function()
	local ft = vim.bo.filetype
	if ft == 'cpp' then
		local filepath = vim.fn.expand("%:p")
		local rootpath = vim.fn.fnamemodify(filepath, ":h")
		local stat = vim.loop.fs_stat(rootpath .. "/CMakeLists.txt")
		Data.is_proj = stat and stat.type == "file"
		Data.root_path = rootpath
	end
end


-- local utils = require('utils')

vim.api.nvim_create_user_command('Project',
function(opts)
	local path = vim.api.nvim_buf_get_name(0)
	local rootpath = vim.fn.fnamemodify(path, ":h")

	local input = opts.fargs[1]
	if input == '../' then
		rootpath = vim.fn.fnamemodify(rootpath, ":h")
	elseif input == '../../' then
		rootpath = vim.fn.fnamemodify(rootpath, ":h")
		rootpath = vim.fn.fnamemodify(rootpath, ":h")
	end

	if vim.fn.isdirectory(rootpath) == 1 then
		Data.is_proj = true
		Data.root_path = rootpath
		vim.api.nvim_echo({{rootpath .. ' has been set as project root', 'DiagnosticOk'}}, false, {})
	else
		vim.api.nvim_echo({{rootpath .. ' is not a path.', 'DiagnosticError'}}, false, {})
	end 
end, {
nargs = 1
})

return {
	check = Check,
	data = Data,
}
