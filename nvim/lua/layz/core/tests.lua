-- Keeping a bunch of test specific configuration here.
-- first lets just start with exercism :Joy:

local function run_test()
	-- In here we can keep code to work out which test runner to run for different languagse?
	-- To start with just want to put down exercism test
	vim.cmd(":vsplit term://exercism test")
end

vim.keymap.set("n", "<C-t>", run_test)
