return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    opts = {},
  },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffViewOpen" }
  },
  {
    "christoomey/vim-tmux-navigator",
    event = "BufEnter",
    config = function(_, conf)
      -- Remove the mappings from nvchad that  interfere with vim tmux navigator
      -- Disable mappings
      local nomap = vim.keymap.del

      nomap({ "n" }, "<C-h>")
      nomap({ "n" }, "<C-l>")
      nomap({ "n" }, "<C-j>")
      nomap({ "n" }, "<C-k>")

      -- or
      -- table.insert(conf.defaults.mappings.i, your table)
      return conf
    end,
  },

  -- test new blink
  { import = "nvchad.blink.lazyspec" },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "rust",
        "solidity",
      },
    },
  },
}
