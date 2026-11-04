return {
  {
    "yetone/avante.nvim",
    version = false,
    enabled = false,

    keys = {
      {
        "<leader>am",
        "<cmd>AvanteACPModes<cr>",
        mode = "n",
        desc = "Avante: Select OpenCode agent",
      },
    },

    opts = {
      provider = "opencode",

      behaviour = {
        auto_set_keymaps = true,

        -- 重要：
        -- 让 OpenCode 的 ask/allow/deny 权限规则真正生效，
        -- 不要让 Avante 自动批准 ACP 权限请求。
        auto_approve_tool_permissions = false,
        confirmation_ui_style = "popup",
      },
    },

    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",

      -- 强烈建议安装：
      -- 提供 Avante 的 / 命令、@ mention，以及 OpenCode ACP 命令补全
      "hrsh7th/nvim-cmp",
    },
  },
}
