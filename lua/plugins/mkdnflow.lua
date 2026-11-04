return {
  "jakewvincent/mkdnflow.nvim",
  ft = "markdown",

  config = function()
    require("mkdnflow").setup({
      -- 链接永远相对于“当前文件”解析
      path_resolution = {
        primary = "current",
        fallback = "current",
        root_marker = false,
        sync_cwd = false,
        update_on_navigate = true,
      },

      links = {
        -- 使用标准 Markdown 链接
        style = "markdown",

        -- 明确显示 .md
        implicit_extension = nil,

        -- 不要自动把文件名变成 2026-09-08_xxx.md
        transform_on_create = false,
        transform_on_follow = false,

        -- 链接不存在时允许创建文件
        auto_create = true,
      },
    })
  end,
}
