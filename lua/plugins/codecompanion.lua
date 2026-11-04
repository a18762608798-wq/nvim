-- ~/.config/nvim/lua/plugins/codecompanion.lua

return {
  {
    "olimorris/codecompanion.nvim",
    enabled = false, -- 暂时禁用.
    version = "^19.0.0",

    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },

    cmd = {
      "CodeCompanion",
      "CodeCompanionChat",
      "CodeCompanionActions",
      "CodeCompanionCmd",
    },

    -- 关键：确保 CodeCompanion / Neovim 能找到 curl 安装的 opencode
    init = function()
      local opencode_bin = vim.fn.expand("~/.opencode/bin")
      local path = vim.env.PATH or ""

      if not path:find(opencode_bin, 1, true) then
        vim.env.PATH = opencode_bin .. ":" .. path
      end
    end,

    keys = {
      {
        "<leader>ac",
        "<cmd>CodeCompanionChat Toggle<cr>",
        mode = { "n", "v" },
        desc = "Toggle (CodeCompanion)",
      },
      {
        "<leader>an",
        "<cmd>CodeCompanionChat<cr>",
        mode = { "n", "v" },
        desc = "Fresh Chat (CodeCompanion)",
      },
      {
        "<leader>ap",
        "<cmd>CodeCompanionActions<cr>",
        mode = { "n", "v" },
        desc = "Prompt Actions (CodeCompanion)",
      },
      {
        "<leader>av",
        function()
          require("utils.codecompanion_preview").toggle()
        end,
        mode = "n",
        desc = "Browser Preview (CodeCompanion)",
      },
      {
        "<leader>ai",
        "<cmd>CodeCompanion<cr>",
        mode = { "n", "v" },
        desc = "Inline (CodeCompanion)",
      },
    },

    opts = {
      adapters = {
        acp = {
          opencode = function()
            return require("codecompanion.adapters").extend("opencode", {
              commands = {
                default = {
                  "opencode",
                  "acp",
                },
              },
              defaults = {
                session_config_options = {
                  thought_level = "xhigh",
                },
              },
              opts = {
                verbose_output = true, -- 显示更详细的 ACP 工具执行摘要.
              },
            })
          end,
        },
      },

      display = {
        chat = {
          show_reasoning = true,
          fold_reasoning = false,
          show_tools_processing = true,
        },
        diff = {
          enabled = true,
          threshold_for_chat = 0,
        },
      },

      interactions = {
        chat = {
          -- 关键：让 Chat 使用 OpenCode ACP
          -- model 可以按你的 OpenCode /models 输出调整
          adapter = {
            name = "opencode",
            -- 注意：ACP 会显式传 model，优先级高于 opencode.jsonc 的默认模型，
            -- 故此处必须与 jsonc 保持完全一致（含 #xhigh 等级后缀），否则回落到 min。
            model = vim.env.OPENCODE_MODEL or "opencode-go/muse-spark-1.3-contributor#xhigh",
          },
          opts = {
            system_prompt = function(ctx)
              return ctx.default_system_prompt
                .. [[

Additional user preferences:
- 你是一个资深中文AI助手。
- 除非用户明确要求其他语言，否则所有解释、总结、提问都默认使用简体中文。
- 代码、命令、文件名、API 名称保持原文。
- 回答先给结论，再给必要说明。
- 对于数学公式，采用$符号的markdown格式。
]]
            end,
          },
        },

        inline = {
          adapter = "opencode",
        },

        cmd = {
          adapter = "opencode",
        },
      },
    },
  },
}
