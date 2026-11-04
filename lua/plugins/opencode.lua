return {
  {
    "sudo-tee/opencode.nvim",
    enabled = false, -- 侧边栏改用 LazyVim Sidekick + Codex。

    dependencies = {
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          anti_conceal = { enabled = false },
          file_types = { "markdown", "opencode_output" },
        },
        ft = { "markdown", "opencode_output" },
      },

      "saghen/blink.cmp",
    },

    opts = {
      preferred_completion = "blink",
    },
  },
}
