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
      require("claude-code").setup {
        -- Terminal window settings
        window = {
          split_ratio = 0.3, -- Percentage of screen for the terminal window (height or width)
          position = "vsplit", -- Position of the window: "botright", "topleft", "vertical"/"vsplit", "float", etc.
          enter_insert = true, -- Whether to enter insert mode when opening Claude Code
          start_in_normal_mode = false, -- Whether to start in normal mode instead of insert mode
          hide_numbers = true, -- Hide line numbers in the terminal window
          hide_signcolumn = true, -- Hide the sign column in the terminal window

          -- Floating window configuration (only applies when position = "float")
          float = {
            width = "80%", -- Width: number of columns or percentage string
            height = "80%", -- Height: number of rows or percentage string
            row = "center", -- Row position: number, "center", or percentage string
            col = "center", -- Column position: number, "center", or percentage string
            relative = "editor", -- Relative to: "editor" or "cursor"
            border = "rounded", -- Border style: "none", "single", "double", "rounded", "solid", "shadow"
          },
        },
        -- File refresh settings
        refresh = {
          enable = true, -- Enable file change detection
          updatetime = 100, -- updatetime when Claude Code is active (milliseconds)
          timer_interval = 1000, -- How often to check for file changes (milliseconds)
          show_notifications = true, -- Show notification when files are reloaded
        },
        -- Git project settings
        git = {
          use_git_root = true, -- Set CWD to git root when opening Claude Code (if in git project)
        },
        -- Command settings
        command = "claude", -- Command used to launch Claude Code (do not include --cwd)
        -- Command variants
        command_variants = {
          -- Conversation management
          continue = "--continue", -- Resume the most recent conversation
          resume = "--resume", -- Display an interactive conversation picker

          -- Output options
          verbose = "--verbose", -- Enable verbose logging with full turn-by-turn output
        },
        -- Keymaps
        keymaps = {
          toggle = {
            normal = "<leader>ac", -- Normal mode keymap for toggling Claude Code
            terminal = "<C-o>", -- Terminal mode keymap for toggling Claude Code
            variants = {
              continue = "<leader>cC", -- Normal mode keymap for Claude Code with continue flag
              verbose = "<leader>cV", -- Normal mode keymap for Claude Code with verbose flag
            },
          },
        },
      }
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
      sessions = {
        sessions_icon = "󱅗 ",
      },
      autoload = true, -- ccether to autoload sessions in the cwd at startup
      autoprompt = true, -- default false. Allows to choose between two sessions if autoload finds two at the same path
      autoswitch = {
        enable = true, -- default false
      },
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
  {
    "folke/zen-mode.nvim",
    event = "VeryLazy",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    keys = {
      { "<leader>sm", "<cmd>ZenMode<CR>", desc = "Toggle ZenMode" },
    },
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
