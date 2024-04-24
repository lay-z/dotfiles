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
vim.lsp.set_log_level("info")

-- Restore these parts of session when reopening nvim
-- https://neovim.io/doc/user/options.html#'sessionoptions'
-- By default vim.o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,terminal'
-- Adding 'globals' to enable restoring of tab names for tabby - https://github.com/nanozuki/tabby.nvim?tab=readme-ov-file#save-and-restore-in-session
-- TODO maybe this should stil in the tabby config section?
opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,terminal,globals"

-- Set up NEOVIDE
-- vim.o.guifont = "Source Code Pro:h9" -- text below applies for VimScript
vim.g.neovide_padding_top = 20
vim.g.neovide_padding_bottom = 20
vim.g.neovide_padding_right = 10
vim.g.neovide_padding_left = 10
vim.g.neovide_floating_blur_amount_x = 20.0
vim.g.neovide_floating_blur_amount_y = 20.0
vim.g.neovide_window_blurred = true
vim.g.neovide_floating_shadow = true
vim.g.neovide_floating_z_height = 10
vim.g.neovide_light_angle_degrees = 45
vim.g.neovide_light_radius = 5
vim.g.neovide_cursor_vfx_mode = "pixiedust"
vim.g.neovide_cursor_vfx_particle_density = 20
vim.g.neovide_cursor_animation_length = 0.05
-- Gives you the effect of explosion on every keypress
vim.g.neovide_cursor_vfx_mode = "sonicboom"

-- TODO figure out how to do this right :joy:
-- Auto command to automatically update nerdtree to use match currently opened window
-- vim.cmd([[
--   autocmd BufEnter * if &modifiable | NERDTreeFind | wincmd p | endif
-- ]])

-- function Test()
-- 	if vim.bo.modifiable then
-- 		vim.cmd("NERDTreeFind")
-- 		-- vim.cmd("wincmd p")
-- 	end
-- end

return config
