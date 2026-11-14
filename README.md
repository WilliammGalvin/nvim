# William's NeoVim config 🧸

This repository is my current nvim config for personal development.
<sub><i>(I use neovim btw)</i></sub>

## Keybinds

`<leader>` = `" "` (space)  
`<localleader>` = `"\\"`

### Editor

**Normal mode**

> *general*

- `Esc` clear search highlight

> *window navigation and splits*

- `Ctrl + h` go to left window
- `Ctrl + l` go to right window
- `Ctrl + j` go to lower window
- `Ctrl + k` go to upper window
- `Leader + |` split window vertically
- `Leader + -` split window horizontally

> *scrolling and searching*

- `Ctrl + d` half-page down, keep cursor centered
- `Ctrl + u` half-page up, keep cursor centered
- `n` next search match, centered
- `N` previous search match, centered

> *editing*

- `J` join lines, keep cursor position
- `x` delete character without yanking
- `Leader + d` delete without yanking
- `Leader + s + r` replace word under cursor in file

**Visual mode**

> *indenting*

- `<` indent left, keep selection
- `>` indent right, keep selection

> *moving lines*

- `J` move selected lines down
- `K` move selected lines up

> *editing*

- `Leader + d` delete selection without yanking
- `Leader + p` paste over selection, keep register

### Terminal

**Normal mode**

- `Leader + f + t` toggle terminal at the bottom

**Terminal mode**

- `Leader + f + t` toggle terminal
- `Esc Esc` close terminal

### Buffers

**Normal mode**

- `Shift + l` next buffer
- `Shift + h` previous buffer
- `Leader + b + d` delete buffer
- `Leader + b + o` delete other buffers
- `Leader + b + b` delete all buffers

### Explorer

**Normal mode**

- `Leader + e` toggle file explorer

**Inside the explorer**

- `/` fuzzy search files
- `f` filter files
- `Ctrl + x` clear filter
- `a` add file or folder (end the name with `/`)
- `d` `r` `c` `m` delete, rename, copy, move
- `H` toggle hidden files
- `?` show all keymaps
- `q` close

### Find

**Normal mode**

- `Leader + f + f` find files
- `Leader + f + g` live grep
- `Leader + f + w` grep word under cursor
- `Leader + f + b` find buffers
- `Leader + f + r` recent files
- `Leader + f + h` help pages
- `Leader + f + k` search keymaps
- `Leader + f + T` find TODO comments
- `Leader + /` search in current file

### Code

**Normal mode**

- `g d` go to definition
- `g D` go to declaration
- `K` hover docs
- `Leader + r + n` rename symbol
- `Leader + c + a` code action
- `Leader + c + d` line diagnostics
- `Leader + c + x` jump to context (function header)
- `] d` / `[ d` next / previous diagnostic
- `] t` / `[ t` next / previous TODO comment

### Git

**Normal mode**

- `] h` / `[ h` next / previous hunk
- `Leader + g + s` stage hunk
- `Leader + g + r` reset hunk
- `Leader + g + p` preview hunk
- `Leader + g + b` blame line
- `Leader + g + B` toggle inline blame
- `Leader + g + d` diff against index

**Visual mode**

- `Leader + g + s` stage selected lines
- `Leader + g + r` reset selected lines

### Misc

**Normal mode**

- `Leader + n + h` message history
- `Leader + ?` keymaps for the current buffer

## Plugins

**Core**

- [lazy.nvim](https://github.com/folke/lazy.nvim) plugin manager
- [plenary.nvim](https://github.com/nvim-lua/plenary.nvim) shared Lua utilities

**Navigation**

- [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) file explorer sidebar
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) fuzzy finder
- [telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim) faster fuzzy matching

**Syntax**

- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) syntax parsing and highlighting
- [nvim-treesitter-context](https://github.com/nvim-treesitter/nvim-treesitter-context) pins the current function header
- [rainbow-delimiters.nvim](https://github.com/HiPhish/rainbow-delimiters.nvim) bracket colors by depth

**LSP and coding**

- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) server definitions
- [mason.nvim](https://github.com/mason-org/mason.nvim) and [mason-lspconfig.nvim](https://github.com/mason-org/mason-lspconfig.nvim) server installer
- [blink.cmp](https://github.com/saghen/blink.cmp) autocompletion
- [friendly-snippets](https://github.com/rafamadriz/friendly-snippets) snippet collection
- [nvim-autopairs](https://github.com/windwp/nvim-autopairs) auto-close brackets and quotes
- [fidget.nvim](https://github.com/j-hui/fidget.nvim) LSP progress indicator

**Git**

- [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) signs, hunks and blame

**UI**

- [tokyonight.nvim](https://github.com/folke/tokyonight.nvim) colorscheme
- [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) statusline
- [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) buffer tabs
- [noice.nvim](https://github.com/folke/noice.nvim) command line and message popups
- [which-key.nvim](https://github.com/folke/which-key.nvim) key hints
- [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) indent guides
- [vim-illuminate](https://github.com/RRethy/vim-illuminate) highlights the word under the cursor
- [todo-comments.nvim](https://github.com/folke/todo-comments.nvim) highlights and searches TODOs
- [mini.hipatterns](https://github.com/echasnovski/mini.hipatterns) hex color previews
