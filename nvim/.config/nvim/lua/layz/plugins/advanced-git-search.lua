return {
    "aaronhallaert/advanced-git-search.nvim",
    cmd = "AdvancedGitSearch",
    keys = {
        { "<leader>gs", "<cmd>AdvancedGitSearch<cr>", desc = "Advanced git search" },
    },
    config = function()
        require("telescope").load_extension("advanced_git_search")
    end,
    dependencies = {
    "nvim-telescope/telescope.nvim",
    "tpope/vim-fugitive",
    "tpope/vim-rhubarb",
    }
}
