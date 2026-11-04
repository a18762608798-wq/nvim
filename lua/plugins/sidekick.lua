return {
  {
    "folke/sidekick.nvim",
    opts = {
      nes = { enabled = false },
      cli = {
        win = { layout = "right" },
      },
    },
    keys = {
      -- 仅使用 CLI，保留原有 Tab 行为。
      { "<tab>", false },
      {
        "<leader>aa",
        function()
          require("sidekick.cli").toggle({ name = "codex", focus = true })
        end,
        desc = "Toggle Codex",
      },
      {
        "<c-.>",
        function()
          require("sidekick.cli").focus({ name = "codex" })
        end,
        desc = "Focus Codex",
        mode = { "n", "t", "i", "x" },
      },
      {
        "<leader>at",
        function()
          require("sidekick.cli").send({ name = "codex", msg = "{this}" })
        end,
        mode = { "n", "x" },
        desc = "Send This to Codex",
      },
      {
        "<leader>af",
        function()
          require("sidekick.cli").send({ name = "codex", msg = "{file}" })
        end,
        desc = "Send File to Codex",
      },
      {
        "<leader>av",
        function()
          require("sidekick.cli").send({ name = "codex", msg = "{selection}" })
        end,
        mode = { "x" },
        desc = "Send Selection to Codex",
      },
    },
  },
}
