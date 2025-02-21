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

local current_path = function()
  local path = vim.api.nvim_buf_get_name(0)
  return path
end

local current_dir = function()
  return vim.fn.getcwd()
end

local parent_path = function(cur_path)
  local parent_path = vim.fn.fnamemodify(cur_path, ":h")
  return parent_path
end

-- ~/vim/src/version.c
local home_path = function(cur_path)
  local path = vim.fn.fnamemodify(cur_path, ":p:~")
  return path
end

local is_dir = function(path)
  return vim.fn.isdirectory(path) == 1
end

local print_ok = function(msg)
  vim.api.nvim_echo({{msg, 'DiagnosticOk'}}, false, {})
end

local print_err = function(msg)
  vim.api.nvim_echo({{msg, 'DiagnosticError'}}, false, {})
end

local create_user_command = function(name, func, nargs)
  vim.api.nvim_create_user_command(name, func, {nargs = nargs})
end

local create_auto_command = function(events, pattern, callback)
  vim.api.nvim_create_autocmd(events, {pattern = pattern, callback = callback})
end

local list_all_files = function(dir)
  if is_dir(dir) then
    return
  end
  -- print(vim.fn.glob(path .. "/*"), "\n", {trimempty = true})
  local files = vim.split(vim.fn.glob(dir .. "/*"), "\n", {trimempty = true})
  for i = 1, #files do
    files[i] = vim.fn.fnamemodify(files[i], ":t")
  end
  return files
end

local check_file_exist = function(dir, target)
  local path = dir .. '/' .. target
  return vim.uv.fs_stat(path) ~= nil and not is_dir(path)
end


local start_with = function(str, prefix)
  -- print(string.sub(str, 1, #prefix))
  return string.sub(str, 1, #prefix) == prefix
end

local end_with = function(str, suffix)
  -- print(string.sub(str, -#suffix))
  return string.sub(str, -#suffix) == suffix
end

-- get the path to the currently executing lua script file
local function script_path()
    local str = debug.getinfo(2, "S").source:sub(2)
    return str:match("(.*[/\\])") or "./"
end

local function float_terminal_exec(cmd)
	vim.cmd("Lspsaga term_toggle")
	vim.api.nvim_chan_send(vim.b.terminal_job_id, cmd .. '\n')
end

local function shell_exec(cmd, workdir)
  local job = vim.fn.jobstart(
    cmd, {
      cwd = workdir
    }
  )
  return job
end

-- usage example as follow:
--
-- utils.shell_exec_react("echo 1", utils.current_dir(),
-- function(chan_id, data, name)
  -- for i = 1, #data do
    -- ret = data[i]
  -- end
-- end)
local function shell_exec_react(cmd, workdir, on_stdout)
  local job = vim.fn.jobstart(
    cmd, {
      cwd = workdir,
      on_stdout = on_stdout
    }
  )
  return job
end

local function tmux_new_window(name, cmd, workdir)
  return shell_exec('tmux new-window -S -n ' .. name .. " " .. cmd, workdir)
end

local function tmux_send_keys(win_name, msg, workdir)
  shell_exec("tmux send-keys -t " .. win_name .. " \"" .. msg .. "\" C-m", workdir)
end

local function send_to_job(job_id, msg)
  vim.api.nvim_chan_send(job_id, msg)
end

local function keymap(mode, keys, func)
  local opts = {
    noremap = true, -- no-recursive
    silent  = true, -- do not show message
  }
  vim.keymap.set(mode, keys, func, opts)
end

return {
	open_win = open_win,
  current_path = current_path,
  current_dir = current_dir,
  parent_path = parent_path,
  home_path = home_path,
  is_dir = is_dir,
  print_ok = print_ok,
  print_err = print_err,
  create_user_command = create_user_command,
  create_auto_command = create_auto_command,
  list_all_files = list_all_files,
  check_file_exist = check_file_exist,
  start_with = start_with,
  end_with = end_with,
  script_path = script_path,
  float_terminal_exec = float_terminal_exec,
  shell_exec = shell_exec,
  shell_exec_react = shell_exec_react,
  tmux_new_window = tmux_new_window,
  tmux_send_keys = tmux_send_keys,
  send_to_job = send_to_job,
  keymap = keymap,
}
