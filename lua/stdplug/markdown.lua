return {
  {
    "iamcco/markdown-preview.nvim",

    cmd = {
      "MarkdownPreview",
      "MarkdownPreviewStop",
      "MarkdownPreviewToggle",
    },

    ft = { "markdown" },

    build = function()
      vim.fn["mkdp#util#install"]()
    end,

    init = function()
      -- 切换 buffer 时不要关闭预览
      vim.g.mkdp_auto_close = 0

      -- 多个 Markdown 文件共用一个浏览器预览页
      vim.g.mkdp_combine_preview = 1

      -- 切换 Markdown buffer 时自动刷新
      vim.g.mkdp_combine_preview_auto_refresh = 1
    end,
  },
}
