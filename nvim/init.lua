-- plugins needs to be first, since installed all plugins which will be used later
require("layz.core.keymaps")
if
	vim.g.vscode
	-- Only things for when running neovim in the vscode extension comes here
then
	require("layz.lazy")
	require("layz.core.tests")
end
require("layz.core.options")
