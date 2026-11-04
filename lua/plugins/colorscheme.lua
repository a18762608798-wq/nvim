-- cyberdream：高对比、色彩鲜明的深色主题；bg 覆盖为纯黑
return {
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      colors = {
        bg = "#000000",
      },
    },
    config = function(_, opts)
      require("cyberdream").setup(opts)
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "cyberdream",
    },
  },
}
