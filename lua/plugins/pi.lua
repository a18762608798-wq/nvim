return {
  {
    "alex35mil/pi.nvim",
    cond = false, -- 暂时禁用.
    config = true,
    -- key
    keys = {
      { "<leader>ip", "<cmd>Pi<cr>", desc = "Pi" },
      { "<leader>ir", "<cmd>PiResume<cr>", desc = "Pi Resume" },
      { "<leader>ic", "<cmd>PiContinue<cr>", desc = "Pi Continue" },
      { "<leader>im", "<cmd>PiSendMention<cr>", mode = { "n", "v" }, desc = "Pi Mention" },
      { "<leader>ia", "<cmd>PiAbort<cr>", desc = "Pi Abort" },
      { "<leader>il", "<cmd>PiToggleLayout<cr>", desc = "Pi Layout" },
    },
  },
  -- pi.completion.blink
  {
    "saghen/blink.cmp",
    optional = true,
    opts = {
      sources = {
        per_filetype = {
          ["pi-chat-prompt"] = { "pi" },
        },
        providers = {
          pi = {
            name = "Pi",
            module = "pi.completion.blink",
          },
        },
      },
    },
  },
  -- clear history
  vim.api.nvim_create_user_command("PiClearView", function()
    local session = require("pi.sessions.manager").get()

    if not session then
      vim.notify("No active Pi session", vim.log.levels.WARN)
      return
    end

    if session.chat:is_streaming() or session.chat:is_compacting() then
      vim.notify("Pi is busy", vim.log.levels.WARN)
      return
    end

    session.chat._history:clear()
    session.chat:focus_prompt()
  end, {
    desc = "Clear Pi history view only",
  }),
}
