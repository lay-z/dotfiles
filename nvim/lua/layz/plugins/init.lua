-- Intialize layz if it isn't installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)




local colourschemes = require('layz/plugins/colour-scheme')

local plugins = {
  "christoomey/vim-tmux-navigator"
}



for i, v in ipairs(colourschemes) do -- Iterate over the second array
  table.insert(plugins, v) -- Append each value to the first array
end

print(vim.inspect(plugins))
local opts = {} --https://github.com/folke/lazy.nvim#%EF%B8%8F-configuration

require("lazy").setup(plugins, opts)
