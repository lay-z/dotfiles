local config = require("layz.config")

local opt = vim.opt -- for conciseness :)

--line numbers
opt.relativenumber = true
opt.number = true

-- tabs & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- line wrapping
opt.wrap = true

-- searching
opt.ignorecase = true -- case insensitive if all lowercase
opt.smartcase = true -- if you have caps in search string, then will be case sensitive https://youtu.be/vdn_pKJUda8?si=QrOrWek76PWIcdJY&t=483q

-- Curosr line
opt.cursorline = true

-- appearance
opt.termguicolors = true
opt.background = config["background"]
vim.cmd.colorscheme(config["colorscheme"])

opt.signcolumn = "yes"

-- backspace key
opt.backspace = "indent,eol,start"

-- clipboard
opt.clipboard:append("unnamedplus") -- used for sharing clipboard between nvim and outside?

-- split windows
opt.splitright = true
opt.splitbelow = true

opt.iskeyword:append("-")

opt.mouse = "a"

-- Set up that log levels
vim.lsp.set_log_level("debug")

-- Restore these parts of session when reopening nvim
-- https://neovim.io/doc/user/options.html#'sessionoptions'
-- By default vim.o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,terminal'
-- Adding 'globals' to enable restoring of tab names for tabby - https://github.com/nanozuki/tabby.nvim?tab=readme-ov-file#save-and-restore-in-session
-- TODO maybe this should stil in the tabby config section?
opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,terminal,globals"

return config
