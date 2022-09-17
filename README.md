# jest.nvim

Ability to invoke jest within nvim.

Based off [mattkubej/jest.nvim](https://github.com/mattkubej/jest.nvim).

## Requirements

* Neovim
* Jest (within node_modules of working project)

## Installation

### vim-plug

```vim
Plug 'walialu/jest.nvim'
```

### packer.nvim

```lua
use 'walialu/jest.nvim'
```

## Default configuration

```lua
require'nvim-jest'.setup {
  -- Jest executable
  -- By default finds jest in the relative project directory
  -- To override with an npm script, provide 'npm test --' or similar
  jest_cmd = '/relative/project/dir/node_modules/jest/bin/jest.js',

  -- Prevents tests from printing messages
  silent = true,
}
```

## Usage

| Command       | Description                        |
| ---           | ---                                |
| `:Jest`       | Run Jest on entire project         |
| `:JestFile`   | Run Jest on file in current buffer |
| `:JestSingle` | Run Jest on test name under cursor |
