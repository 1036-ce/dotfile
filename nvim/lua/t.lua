local utils = require('utils')

local dir = ""
local stop_dir = os.getenv("HOME")
local target_file = ".nvim" -- it should be in project's root dir
local black_list = {
  "~/workspace/tmp",
}

local function in_black_list()
  local path = utils.current_path();
  path = utils.home_path(path)
  for i = 1, #black_list do
    if utils.end_with(path, black_list[i]) == true then
      return true
    end
  end
  return false
end

local function check_and_load()
  local cur_path = utils.current_path()

  -- do not open any file
  if cur_path == "" then
    return
  end

  dir = utils.parent_path(cur_path)

  while (dir ~= stop_dir)
  do
    if utils.check_file_exist(dir, target_file) then
      dofile(dir .. "/" .. target_file)
      break;
    end
    dir = utils.parent_path(dir)
  end
end

utils.create_auto_command(
  {"VimEnter"},
  {"*.c", "*.h", "*.cpp", "*.hpp", "*.y", "*.l"},
  function()
    if not in_black_list() then
      check_and_load()
    end
  end
)

utils.create_user_command("ProjInfo",
function()
  if dir == stop_dir then
    utils.print_err("no " .. target_file .. " is loaded")
  else
    utils.print_ok(utils.home_path(dir) .. target_file .. " is loaded")
  end
end, 0)


utils.create_user_command("Test",
function()
end,
0)

utils.create_user_command("ReloadConfig",
function()
  dofile(dir .. "/" .. target_file);
end, 0)
