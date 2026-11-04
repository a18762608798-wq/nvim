return {
  {
    "milanglacier/minuet-ai.nvim",
    event = "InsertEnter",
    opts = {
      provider = "openai_compatible",

      -- 虽然当前 Minuet 默认就是 true，但显式保留：
      -- 这是之前自动补全问题的关键配置。
      blink = {
        enable_auto_complete = false,
      },

      request_timeout = 3,
      throttle = 1000,
      debounce = 400,
      n_completions = 1,

      provider_options = {
        openai_compatible = {
          name = "Opencode",
          api_key = "OPENCODE_API_KEY",
          end_point = "https://opencode.ai/zen/go/v1/chat/completions",
          model = "deepseek-v4-flash",
          stream = true,
          optional = {
            max_tokens = 128,
            top_p = 0.9,
            thinking = {
              type = "disabled",
            },
          },
        },
      },
    },
  },

  {
    "saghen/blink.cmp",
    optional = true,
    opts = function(_, opts)
      opts.keymap = opts.keymap or {}
      opts.keymap["<A-y>"] = {
        function(cmp)
          cmp.show({ providers = { "minuet" } })
        end,
      }

      opts.sources = opts.sources or {}
      opts.sources.default = opts.sources.default or { "lsp", "path", "snippets", "buffer" }

      if not vim.tbl_contains(opts.sources.default, "minuet") then
        table.insert(opts.sources.default, "minuet")
      end

      opts.sources.providers = opts.sources.providers or {}
      opts.sources.providers.minuet = {
        name = "minuet",
        module = "minuet.blink",
        async = true,
        timeout_ms = 3000,
        score_offset = 100,
      }

      opts.completion = vim.tbl_deep_extend("force", opts.completion or {}, {
        trigger = {
          prefetch_on_insert = false,
        },
      })
    end,
  },
}
