return {
  {
    "jalvesaq/zotcite",

    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim",
    },

    config = function()
      local zotcite = require("zotcite")
      zotcite.setup({
        -- 默认用 Zotero 打开 pdf
        open_in_zotero = true,
        -- Ubuntu 默认的 Zotero 数据库位置
        zotero_sqlite_path = vim.fn.expand("~/Zotero/zotero.sqlite"),

        -- 生成类似 smith2024title 的可读引用键
        key_type = "template",
      })

      -- 非 Zotero 笔记的 markdown/qmd 没有 bibliography 字段，
      -- 保存时总是弹出 "Could not find 'bibliography' field in YAML header."，
      -- 这里包装 zwarn 过滤掉这条警告。
      local zwarn = zotcite.zwarn
      zotcite.zwarn = function(msg, store)
        if msg:find("Could not find 'bibliography' field in YAML header.") then
          return
        end
        zwarn(msg, store)
      end

      -- 手动触发 Zotcite 引用补全（@ 自动触发不可靠）
      vim.keymap.set("i", "<C-z>", "<C-x><C-b>", {
        remap = true,
        desc = "Zotcite citation completion",
      })
    end,
  },
}
