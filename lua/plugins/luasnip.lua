return {
  {
    "L3MON4D3/LuaSnip",
    opts = function(_, opts)
      require("luasnip").filetype_extend("markdown", { "tex" })
      return opts
    end,
  },
}
