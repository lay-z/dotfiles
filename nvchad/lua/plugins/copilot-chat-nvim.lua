return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    event = "VeryLazy",
    opts = {
      -- model = "nothingiisreal/mn-celeste-12b",
      -- provider = "openrouter",
      providers = {
        -- copilot = {
        --   disabled = true,
        -- },
        -- github_models = {
        --   disabled = true,
        -- },
        -- copilot_embeddings = {
        --   disabled = true,
        -- },
        openrouter = {
          prepare_input = function(inputs, opts)
            local is_o1 = vim.startswith(opts.model.id, "o1")

            inputs = vim.tbl_map(function(input)
              if is_o1 then
                if input.role == "system" then
                  input.role = "user"
                end
              end

              return input
            end, inputs)

            local out = {
              messages = inputs,
              model = opts.model.id,
            }

            if not is_o1 then
              out.n = 1
              out.top_p = 1
              out.stream = true
              out.temperature = opts.temperature
            end

            if opts.model.max_output_tokens then
              out.max_tokens = opts.model.max_output_tokens
            end

            return out
          end,

          prepare_output = function(output)
            local references = {}

            if output.copilot_references then
              for _, reference in ipairs(output.copilot_references) do
                local metadata = reference.metadata
                if metadata and metadata.display_name and metadata.display_url then
                  table.insert(references, {
                    name = metadata.display_name,
                    url = metadata.display_url,
                  })
                end
              end
            end

            local message
            if output.choices and #output.choices > 0 then
              message = output.choices[1]
            else
              message = output
            end

            local content = message.message and message.message.content or message.delta and message.delta.content

            local usage = message.usage and message.usage.total_tokens or output.usage and output.usage.total_tokens

            local finish_reason = message.finish_reason
              or message.done_reason
              or output.finish_reason
              or output.done_reason

            return {
              content = content,
              finish_reason = finish_reason,
              total_tokens = usage,
              references = references,
            }
          end,

          get_headers = function()
            local api_key = assert(os.getenv "OPENROUTER_API_KEY", "OPENROUTER_API_KEY env not set")
            return {
              Authorization = "Bearer " .. api_key,
              ["Content-Type"] = "application/json",
            }
          end,

          get_models = function(headers)
            local response, err = require("CopilotChat.utils").curl_get("https://openrouter.ai/api/v1/models", {
              headers = headers,
              json_response = true,
            })

            if err then
              error(err)
            end

            return vim
              .iter(response.body.data)
              :map(function(model)
                return {
                  id = model.id,
                  name = model.name,
                }
              end)
              :totable()
          end,

          get_url = function()
            return "https://openrouter.ai/api/v1/chat/completions"
          end,
        },
      },
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
}
