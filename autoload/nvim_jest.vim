function nvim_jest#test_project()
  call luaeval('require("nvim-jest").test_project()')
endfunction

function nvim_jest#test_file()
  call luaeval('require("nvim-jest").test_file()')
endfunction

function nvim_jest#test_single()
  call luaeval('require("nvim-jest").test_single()')
endfunction

function nvim_jest#test_integrated()
  call luaeval('require("nvim-jest-integrated").test_integrated()')
endfunction

function nvim_jest#test_integrated_clear()
  call luaeval('require("nvim-jest-integrated").test_integrated_clear()')
endfunction


