-- snacks are used to add some small tools.
return {
  {
    "folke/snacks.nvim",
    opts = {
      image = {
        enabled = false, -- 感觉这个图像显示没有什么作用，暂时不用。
      },
      picker = {
        sources = {
          explorer = {
            -- 隐藏 otter.nvim 为 qmd 生成的临时伴随文件（*.otter.jl, *.otter.py）
            exclude = { "*.otter.jl", "*.otter.py" },
          },
        },
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "image",
        callback = function(ev)
          vim.bo[ev.buf].bufhidden = "wipe"
          vim.bo[ev.buf].swapfile = false
        end,
      })
    end,
  },
}
