function get_context_scoop()
	local get_current_context = require("indent_blankline.utils").get_current_context
	local v = require("indent_blankline.utils").get_variable
	local _, start, end_, _ = get_current_context(v "indent_blankline_context_patterns", v "indent_blankline_use_treesitter_scope")
	return start, end_
end

local opts = {
	noremap = true, -- no-recursive
	silent  = true, -- do not show message
}


vim.keymap.set("i", "jj", "<Esc>", opts)
vim.keymap.set("n", "<C-a>", "ggVG", opts)
vim.keymap.set("n", "<leader>e", "<Cmd>DiagnosticToggle<CR>", opts)
vim.keymap.set({"n", "v"}, "H", "^", opts)
vim.keymap.set({"n", "v"}, "L", "$", opts)
vim.keymap.set({"n", "v"}, ",", "%", opts)

-- format
-- vim.keymap.set({"n"}, "<leader>m", "<Cmd>%!clang-format<CR><Cmd>w<CR>", opts)
vim.keymap.set({"n"}, "<leader>m",
function()
	local ft = vim.bo.filetype
	if ft ~= 'cpp' then
		vim.api.nvim_echo({{ft .. " file can not be formated", "DiagnosticError"}}, false, {})
		return
	end

	local current_line = vim.fn.line('.')
	local mark = 'a'

	-- make a mark as 'a'
	vim.fn.setpos("'" .. mark, {0, current_line, 0, 0})
	vim.cmd(":%!clang-format")
	vim.cmd(":w")

	-- go back mark
	vim.cmd("normal! '" .. mark)

	-- clear mark 
	vim.cmd("delmarks " .. mark)

	-- go to center
	vim.api.nvim_command('normal! zz')
end
, opts)

local exec = function(cmd)
	-- local timer = vim.loop.new_timer()
	vim.cmd("Lspsaga term_toggle")
	vim.api.nvim_chan_send(vim.b.terminal_job_id, cmd .. '\n')
	--[[ timer:start(350, 0, vim.schedule_wrap(function()
	   [     vim.api.nvim_chan_send(vim.b.terminal_job_id, cmd)
	   [ end))  ]]
end


local proj = require('project')

-- only for debug
vim.keymap.set('n', '<F4>',
function()
	print(proj.data.is_proj)
	print(proj.data.root_path)
end,opts)


local build = function()
	local build_path = proj.data.root_path .. '/build';
	local build_exist = vim.fn.isdirectory(build_path) == 1
	if build_exist == false then
		vim.fn.system("mkdir -p " .. build_path)
	end
	local cmd = "cmake -S " .. proj.data.root_path .. " -B " .. build_path
	cmd = cmd .. ' && cd ' .. build_path .. ' && make -j ${nproc}'
	exec(cmd)
end

-- compile and build
vim.keymap.set('n', '<F10>',
function()
	local ft = vim.bo.filetype
	local path = vim.api.nvim_buf_get_name(0)
	local filename = path:match("[^/]+$")
	local target_name = vim.fn.fnamemodify(filename, ":r")

	-- if this is a project, then config and build
	if proj.data.is_proj == true then
		build()
		return
	end

	if ft == 'c' then
		local cmd = "gcc -g -Wall -o " .. target_name .. " " .. filename
		exec(cmd)
	elseif ft == 'cpp' then
		local cmd = "g++ -std=c++20 -g -Wall -o " .. target_name .. " " .. filename
		exec(cmd)
	elseif ft == 'cmake' then
		local build_path = './build';
		local build_exist = vim.fn.isdirectory(build_path) == 1
		if build_exist == false then
			vim.fn.system("mkdir -p " .. build_path)
		end
		local cmd = "cmake -S . -B build"
		exec(cmd)
	else
		vim.api.nvim_echo({{ft .. " file is not supported", "DiagnosticError"}}, false, {})
	end
end,opts)

-- run
vim.keymap.set('n', '<F9>',
function()
	local ft = vim.bo.filetype
	local path = vim.api.nvim_buf_get_name(0)
	local filename = path:match("[^/]+$")
	local target_name = vim.fn.fnamemodify(filename, ":r")

	-- if this is a project
	if proj.data.is_proj == true then
		local cmd = "cd " .. proj.data.root_path .. " && ./run.sh"
		local run_sh = proj.data.root_path .. '/run.sh'
		if vim.fn.filereadable(run_sh) == 1 then
			exec(cmd)
		else
			vim.api.nvim_echo({{"The run.sh file does not exist", "DiagnosticError"}}, false, {})
		end
		return
	end

	if ft == 'c' or ft == 'cpp' then
		exec("./" .. target_name)
	elseif ft == 'cmake' then
		-- print('cmake file running')
		exec("cmake --build build")
	else
		vim.api.nvim_echo({{ft .. " file is not supported", "DiagnosticError"}}, false, {})
	end
end
,opts)

vim.keymap.set('n', '{',
function()
	local start, _ = get_context_scoop()
	local cur = vim.fn.line('.')
	if start ~= nil and start ~= cur then
		vim.cmd(":" .. start)
	else
		vim.cmd(":" .. cur - 1)
	end
end, opts)

vim.keymap.set('n', '}',
function()
	local start, end_ = get_context_scoop()
	local cur = vim.fn.line('.')
	if end_ ~= nil and end_ ~= cur then
		vim.cmd(":" .. end_)
	else
		vim.cmd(":" .. cur + 1)
	end
end, opts)

-- nvim terminal mode
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", opts)

-- Better window navigation
vim.keymap.set('n', '<M-h>', '<C-w>h', opts)
vim.keymap.set('n', '<M-j>', '<C-w>j', opts)
vim.keymap.set('n', '<M-k>', '<C-w>k', opts)
vim.keymap.set('n', '<M-l>', '<C-w>l', opts)

--------------------------------------------------------------------------------
--                           Bufferline keymap                                --
--------------------------------------------------------------------------------
for i = 1, 9 do
	vim.keymap.set('n', '<M-' .. i .. '>', '<Cmd>BufferLineGoToBuffer' .. i .. '<CR>', opts)
end
vim.keymap.set('n', 'J', '<Cmd>BufferLineCyclePrev<CR>')
vim.keymap.set('n', 'K', '<Cmd>BufferLineCycleNext<CR>')
vim.keymap.set('n', '<C-j>', '<Cmd>BufferLineMovePrev<CR>')
vim.keymap.set('n', '<C-k>', '<Cmd>BufferLineMoveNext<CR>')
vim.keymap.set('n', '<leader>q', function()
	if vim.bo.modified then
		vim.cmd.write()
	end
	local bufnums = vim.fn.len(vim.fn.getbufinfo({ buflisted = 1 }))
	if bufnums == 1 then
		vim.cmd.quit()
	else
		local buf = vim.fn.bufnr()
		vim.cmd.bdelete(buf)
		-- vim.cmd.goto_prev()
		vim.cmd.bnext()
	end
end)
vim.keymap.set('n', '<leader>w', function()
	if vim.bo.modified then
		vim.cmd.write()
	end
end)

--------------------------------------------------------------------------------
--                           ToggleTerm keymap                                --
--------------------------------------------------------------------------------
vim.keymap.set({'n', 't'}, '<M-t>', "<Cmd>ToggleTerm direction=horizontal<CR>", opts )
vim.keymap.set({'n', 't'}, '<leader>tf', "<Cmd>ToggleTerm direction=float<CR>", opts )

--------------------------------------------------------------------------------
--                           NvimTree keymap                                  --
--------------------------------------------------------------------------------
vim.keymap.set('n', '<leader>fm', "<Cmd>NvimTreeToggle<CR>", opts)


--------------------------------------------------------------------------------
--                           lspsaga keymap                                   --
--------------------------------------------------------------------------------
-- LSP finder - Find the symbol's definition
-- If there is no definition, it will instead be hidden
-- When you use an action in finder like "open vsplit",
-- you can use <C-t> to jump back
vim.keymap.set("n", "gh", "<cmd>Lspsaga finder<CR>", opts)

-- Code action
vim.keymap.set({"n","v"}, "ca", "<cmd>Lspsaga code_action<CR>", opts)

-- Rename all occurrences of the hovered word for the entire file
vim.keymap.set("n", "rn", "<cmd>Lspsaga rename<CR>", opts)

-- Rename all occurrences of the hovered word for the selected files
vim.keymap.set("n", "ra", "<cmd>Lspsaga rename ++project<CR>", opts)

-- Peek definition
-- You can edit the file containing the definition in the floating window
-- It also supports open/vsplit/etc operations, do refer to "definition_action_keys"
-- It also supports tagstack
-- Use <C-t> to jump back
vim.keymap.set("n", "gp", "<cmd>Lspsaga peek_definition<CR>", opts)

-- Go to definition
vim.keymap.set("n","gd", "<cmd>Lspsaga goto_definition<CR>", opts)

-- Peek type definition
-- You can edit the file containing the type definition in the floating window
-- It also supports open/vsplit/etc operations, do refer to "definition_action_keys"
-- It also supports tagstack
-- Use <C-t> to jump back
vim.keymap.set("n", "gt", "<cmd>Lspsaga peek_type_definition<CR>", opts)

-- Go to type definition
vim.keymap.set("n","gt", "<cmd>Lspsaga goto_type_definition<CR>", opts)


-- Show line diagnostics
-- You can pass argument ++unfocus to
-- unfocus the show_line_diagnostics floating window
vim.keymap.set("n", "<leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)

-- Show buffer diagnostics
vim.keymap.set("n", "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>", opts)

-- Show workspace diagnostics
vim.keymap.set("n", "<leader>sw", "<cmd>Lspsaga show_workspace_diagnostics<CR>", opts)

-- Show cursor diagnostics
vim.keymap.set("n", "<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts)

-- Diagnostic jump
-- You can use <C-o> to jump back to your previous location
vim.keymap.set("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
vim.keymap.set("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)

-- Diagnostic jump with filters such as only jumping to an error
vim.keymap.set("n", "[E", function()
  require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR }, opts)
end)
vim.keymap.set("n", "]E", function()
  require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR }, opts)
end)

-- Toggle outline
vim.keymap.set("n","<leader>o", "<cmd>Lspsaga outline<CR>", opts)

-- Hover Doc
-- If there is no hover doc,
-- there will be a notification stating that
-- there is no information available.
-- To disable it just use ":Lspsaga hover_doc ++quiet"
-- Pressing the key twice will enter the hover window
vim.keymap.set("n", "<leader>k", "<cmd>Lspsaga hover_doc<CR>", opts)

-- If you want to keep the hover window in the top right hand corner,
-- you can pass the ++keep argument
-- Note that if you use hover with ++keep, pressing this key again will
-- close the hover window. If you want to jump to the hover window
-- you should use the wincmd command "<C-w>w"
-- vim.keymap.set("n", "<leader>k", "<cmd>Lspsaga hover_doc ++keep<CR>")

-- Call hierarchy
vim.keymap.set("n", "ci", "<cmd>Lspsaga incoming_calls<CR>")
vim.keymap.set("n", "co", "<cmd>Lspsaga outgoing_calls<CR>")

-- Floating terminal
vim.keymap.set({"n", "t"}, "<M-d>", "<cmd>Lspsaga term_toggle<CR>", opts)

--------------------------------------------------------------------------------
--                           telescope keymap                                 --
--------------------------------------------------------------------------------
vim.keymap.set('n', '<leader>ff', "<Cmd>Telescope find_files<CR>", opts)
vim.keymap.set('n', '<leader>fg', "<Cmd>Telescope live_grep<CR>", opts)
vim.keymap.set('n', '<leader>fb', "<Cmd>Telescope buffers<CR>", opts)
vim.keymap.set('n', '<leader>fh', "<Cmd>Telescope help_tags<CR>", opts)
