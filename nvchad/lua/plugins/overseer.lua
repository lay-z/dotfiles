return {
  "stevearc/overseer.nvim",
  opts = {},
  keys = {
    {
      "<leader>rl",
      function()
        vim.cmd("OverseerRestartLast")
      end,
      desc = "Run last task",
    },
    {
      "<leader>rr",
      function()
        vim.cmd("OverseerRun")
      end,
      desc = "Bring up list of available tasks to run",
    },
    {
      "<leader>rs",
      function()
        vim.cmd("OverseerToggle")
      end,
      desc = "Toggle the overseer output",
    },
  },
  config = function(_, opts)
    require("overseer").setup(opts)

    vim.api.nvim_create_user_command("OverseerRestartLast", function()
      local overseer = require("overseer")
      local tasks = overseer.list_tasks({ recent_first = true })
      if vim.tbl_isempty(tasks) then
        vim.notify("No tasks found", vim.log.levels.WARN)
      else
        overseer.run_action(tasks[1], "restart")
      end
    end, {})
  end,
  event = "VeryLazy",
}
