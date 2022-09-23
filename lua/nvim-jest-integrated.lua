local exports = {}
local state = {}
local ns_id = vim.api.nvim_create_namespace('jest.nvim')

local function clear_tests()
  vim.api.nvim_buf_clear_namespace(0, ns_id, 0, -1)
end

local function get_current_file_path()
  return vim.fn.expand('%:p')
end

local function get_current_folder_path()
  return vim.fn.expand('%:p:h')
end

local function get_current_line_number()
  local linenr = vim.api.nvim_win_get_cursor(0)[1]
  return linenr
end

local function run_jest(args)
  vim.api.nvim_buf_clear_namespace(0, ns_id, 0, -1)

  local t = {}
  table.insert(t, 'jest --json')

  if args ~= nil then
    for _, v in pairs(args) do
      table.insert(t, v)
    end
  end

  local jest_cmd = table.concat(t, '')
  local linenr = get_current_line_number()
  local test_result_status = ""

  local start_time = os.time()
  print('Starting integrated Jest results..')
  local output = ""
  vim.fn.jobstart(jest_cmd, {
    on_stdout = function(_, data)
      output = output .. vim.fn.join(data)
      local decoded = vim.json.decode(output)
      local test_results = decoded.testResults
      for index_test_results in pairs(test_results) do
        local test_result = test_results[index_test_results]
        test_result_status = test_result.status
      end
      local end_time = os.time()
      local elapsed_time = os.difftime(end_time, start_time)
      print("Integrated Jest tests took:", elapsed_time, "seconds to complete.")
    end,
    on_exit = function()
      local text = { "✅" }
      local bufnr = vim.api.nvim_get_current_buf()
      if (test_result_status ~= "passed") then
        text = { "❌" }
      end
      vim.api.nvim_buf_set_extmark(bufnr, ns_id, linenr - 1, 0, {
        virt_text = { text }
      })
    end
  })
end

local function test_single()
  local c_file = get_current_file_path()
  local line = vim.api.nvim_get_current_line()

  local _, _, test_name = string.find(line, "^%s*%a+%(['\"](.+)['\"]")

  if test_name ~= nil then
    local args = {}
    table.insert(args, ' --runTestsByPath ' .. c_file)
    table.insert(args, " -t='" .. test_name .. "'")
    run_jest(args)
  else
    print('ERR: Could not find test name. Place cursor on line with test name.')
  end
end


function exports.test_integrated()
  test_single()
end

function exports.test_integrated_clear()
  clear_tests()
end

return exports

