-- No longer cloneable?
-- Failed (1)
--   ○ tabline.nvim
--       Cloning into '/home/layz/.local/share/nvim/lazy/tabline.nvim'...
--       fatal: could not read Username for 'https://github.com': terminal prompts disabled
-- return {
-- 	-- TODO for some reason couldnt' get tabby to work. Tabline seems to work good for now
-- 	-- "nanozuki/tabby.nvim",
-- 	-- event = "VimEnter",
-- 	-- dependencies = "nvim-tree/nvim-web-devicons",
-- 	-- config = function()
-- 	--   -- configs...
-- 	-- end,
-- 	"https://github.com/mg979/tabline.nvim",
-- 	config = function()
-- 		require("tabline.setup").setup()
-- 		require("tabline.setup").mappings()
-- 	end,
-- }
