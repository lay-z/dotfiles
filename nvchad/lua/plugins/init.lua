return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- AI stuff
  {
    "greggh/claude-code.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim", -- Required for git operations
    },
    cmd = { "ClaudeCode", "ClaudeCodeContinue", "ClaudeCodeVerbose", "ClaudeCodeResume" },
    event = "VeryLazy",
    keys = {
      { "<C-,>", "<cmd>ClaudeCode<CR>", desc = "Toggle Claude Code" },
      { "<leader>cc", "<cmd>ClaudeCodeContinue<CR>", desc = "Claude Code Continue" },
      { "<leader>cV", "<cmd>ClaudeCodeVerbose<CR>", desc = "Claude Code Verbose" },
      { "<leader>cC", "<cmd>ClaudeCode<CR>", desc = "Start up Claude Code" },
    },
    config = function()
      require("claude-code").setup()
    end,
  },
  {
    {
      "CopilotC-Nvim/CopilotChat.nvim",
      dependencies = {
        { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
        { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
      },
      build = "make tiktoken", -- Only on MacOS or Linux
      event = "VeryLazy",
      opts = {
        mappings = {
          complete = {
            normal = "<C-y>",
            insert = "<C-y>",
          },
        },
        -- See Configuration section for options - https://github.com/CopilotC-Nvim/CopilotChat.nvim?tab=readme-ov-file#configuration
      },
      keys = {
        { "<Leader>ca", "<cmd>CopilotChatToggle<CR>", desc = "Toggle Copilot Chat" },
      },
      -- See Commands section for default commands if you want to lazy load on them
    },
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "gennaro-tedesco/nvim-possession",
    dependencies = {
      "ibhagwan/fzf-lua",
    },
    config = true,
    opts = {
      autoload = true, -- whether to autoload sessions in the cwd at startup
    },
    event = "VeryLazy",
    keys = {
      {
        "<leader>sl",
        function()
          require("nvim-possession").list()
        end,
        desc = "📌list sessions",
      },
      {
        "<leader>sn",
        function()
          require("nvim-possession").new()
        end,
        desc = "📌create new session",
      },
      {
        "<leader>su",
        function()
          require("nvim-possession").update()
        end,
        desc = "📌update current session",
      },
      {
        "<leader>sd",
        function()
          require("nvim-possession").delete()
        end,
        desc = "📌delete selected session",
      },
    },
  },
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    opts = {},
  },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffViewOpen" },
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
