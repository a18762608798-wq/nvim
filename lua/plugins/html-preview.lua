-- ~/.config/nvim/lua/plugins/html-preview.lua

return {
  {
    "brianhuster/live-preview.nvim",
    dependencies = {
      "folke/snacks.nvim",
    },
    opts = {},
    keys = {
      {
        "<leader>cp",
        "<cmd>LivePreview start<cr>",
        desc = "HTML Preview",
      },
      {
        "<leader>cP",
        "<cmd>LivePreview close<cr>",
        desc = "Stop HTML Preview",
      },
    },
  },
}
