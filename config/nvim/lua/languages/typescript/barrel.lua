local BARREL_FILENAME = 'index.ts'
local FILE_EXTENSION = '.ts'
local EXPORT_STATEMENT = "export * from './%s';\n"

local function open_file_for_writing(file_path)
  local file, err = io.open(file_path, "w")
  if not file then
    error("Error: Unable to open file for writing - " .. err)
  end
  return file
end

-- Function to retrieve all TypeScript files in the current directory excluding the barrel file
local function get_typescript_files()
  local handle = io.popen('ls *' .. FILE_EXTENSION)  -- Fetch only .ts files
  if not handle then
    error("Error: Unable to list files in the directory")
  end

  local ts_files = {}
  for file_name in handle:lines() do
    -- Exclude the barrel file itself
    if file_name ~= BARREL_FILENAME then
      table.insert(ts_files, file_name)
    end
  end
  handle:close()
  return ts_files
end

-- Function to write the barrel (index.ts) file with export statements for each TypeScript file
local function write_barrel_file(ts_files)
  if #ts_files == 0 then
    print("No TypeScript files found. " .. BARREL_FILENAME .. " not created.")
    return
  end

  -- Get the path of the current working directory
  local current_dir = vim.fn.getcwd()
  local barrel_file_path = current_dir .. '/' .. BARREL_FILENAME

  -- Open the barrel file for writing
  local barrel_file = open_file_for_writing(barrel_file_path)

  -- Write export statements for each TypeScript file
  for _, file_name in ipairs(ts_files) do
    -- Strip the .ts extension before writing the export statement
    local module_name = file_name:gsub(FILE_EXTENSION .. "$", "")
    barrel_file:write(EXPORT_STATEMENT:format(module_name))
  end

  barrel_file:close()

  print(BARREL_FILENAME .. " created with exports.")
end

local function create_barrel()
  local ts_files = get_typescript_files()

  if not ts_files then
    print("Error retrieving TypeScript files.")
    return
  end

  write_barrel_file(ts_files)
end


return {
  create_barrel = create_barrel
}
