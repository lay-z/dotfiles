return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },
  {
    "pwntester/octo.nvim",
    event = "VeryLazy",
    config = function()
      require("octo").setup { enable_builtin = true }
    end,
    keys = {
      { "<leader>O", "<cmd>Octo<cr>", desc = "List octo actions" },
    },
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      -- OR 'ibhagwan/fzf-lua',
      -- OR 'folke/snacks.nvim',
      "nvim-tree/nvim-web-devicons",
    },
  },
  -- AI stuff

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
    cmd = { "DiffviewOpen" },
  },
  {
    "christoomey/vim-tmux-navigator",
    event = "VeryLazy",
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        mappings = {
          i = {
            ["<c-d>"] = require("telescope.actions").delete_buffer,
          },
          n = {
            ["<c-d>"] = require("telescope.actions").delete_buffer,
            ["dd"] = require("telescope.actions").delete_buffer,
          },
        },
      },
    },
  },
  {
    "vim-test/vim-test",
    -- cmd = { "testnearest", "testfile", "testsuite", "testlast", "testvisit" },
    event = "VeryLazy",
    dependencies = { "akinsho/toggleterm.nvim" },
    vim.keymap.set("n", "<leader>tt", "<cmd>:TestNearest<CR>"),
    vim.keymap.set("n", "<leader>tT", "<cmd>:TestFile<CR>"),
    vim.keymap.set("n", "<leader>ta", "<cmd>:TestSuite<CR>"),
    vim.keymap.set("n", "<leader>tl", "<cmd>:TestLast<CR>"),
    vim.keymap.set("n", "<leader>tg", "<cmd>:TestVisit<CR>"),
    vim.cmd "let test#strategy = 'toggleterm'", -- Use toggle term
    vim.cmd "let test#neovim_sticky#reopen_window = 1", -- Reopen terminal split if not visible
    -- vim.cmd("let test#project_root = function('get_base_dir'"),
  },

  -- Python things ---
  -- For a jupyter notebook
  {
    "kiyoon/jupynium.nvim",
    dependencies = {
      "rcarriga/nvim-notify", -- optional
      "stevearc/dressing.nvim", -- optional, UI for :JupyniumKernelSelect
    },
    build = "uv pip install . --python=$HOME/.virtualenvs/jupynium/bin/python",
    event = "VeryLazy",
    opts = {
      auto_start_server = {
        enable = true,
        file_pattern = { "*.ju.*" },
      },
    },
    -- build = "pip3 install --user .",
    -- build = "conda run --no-capture-output -n jupynium pip install .",
  },

  -- blink-copilot integration
  -- {
  --   "fang2hou/blink-copilot",
  --   dependencies = {
  --     "saghen/blink.cmp",
  --   },
  --   event = "VeryLazy",
  -- },
  --
  -- -- test new blink
  -- {
  --   import = "nvchad.blink.lazyspec",
  --   opts = {
  --     sources = {
  --       default = {
  --         "jupynium",
  --         "copilot",
  --         -- ...
  --       },
  --       providers = {
  --         jupynium = {
  --           name = "Jupynium",
  --           module = "jupynium.blink_cmp",
  --           -- Consider higher priority than LSP
  --           score_offset = 100,
  --         },
  --         copilot = {
  --           name = "copilot",
  --           module = "blink-copilot",
  --           score_offset = 100,
  --           async = true,
  --         },
  --         -- ...
  --       },
  --     },
  --   },
  -- },

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
