return {
  {
    "quarto-dev/quarto-nvim",
    ft = { "quarto", "markdown" },
    dependencies = {
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter",
      "Vigemus/iron.nvim",
    },
    init = function()
      -- quarto.nvim only auto-activates its `quarto` ftplugin. Use Otter's
      -- default Markdown injections so ordinary ```python/```julia blocks work.
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("quarto_markdown", { clear = true }),
        pattern = "markdown",
        callback = function(args)
          vim.schedule(function()
            if not vim.api.nvim_buf_is_valid(args.buf) or vim.bo[args.buf].filetype ~= "markdown" then
              return
            end

            local lsp = QuartoConfig.lspFeatures
            vim.api.nvim_buf_call(args.buf, function()
              require("otter").activate(lsp.languages, lsp.completion.enabled, lsp.diagnostics.enabled)
            end)
          end)
        end,
      })
    end,
    opts = {
      lspFeatures = {
        enabled = true,
        chunks = "curly",
        languages = { "python", "julia" },
        completion = {
          enabled = true,
        },
        diagnostics = {
          enabled = true,
          triggers = { "BufWritePost" },
        },
      },
      codeRunner = {
        enabled = true,
        default_method = "iron",
        never_run = { "yaml" },
      },
    },
    keys = {
      {
        "<leader>qv",
        function()
          require("quarto").quartoPreview({})
        end,
        desc = "Quarto Preview",
      },
    },
  },
}
