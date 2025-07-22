return {
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
}
