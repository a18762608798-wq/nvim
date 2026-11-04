return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      opts.setup = opts.setup or {}

      local lsp_bin = vim.fn.expand("~/.local/share/nvim/mason/bin/julia-lsp")

      opts.servers.julials = vim.tbl_deep_extend("force", opts.servers.julials or {}, {
        settings = {
          julia = {
            completionmode = "qualify",
            lint = {
              missingrefs = "all",
            },
          },
        },
      })

      opts.setup.julials = function(server, server_opts)
        -- mason 生成的 wrapper 可能因升级/重装/新机器缺装而失效：先探测，
        -- 缺失就明示通知并跳过，避免装一个起不来的 broken client。
        if vim.fn.executable(lsp_bin) ~= 1 then
          vim.notify(
            "julia-lsp 缺失：" .. lsp_bin .. "，请跑 :Mason 装回 julia-lsp（本次跳过 Julia LSP）",
            vim.log.levels.WARN
          )
          return true
        end

        local function julia_env(root_dir)
          return require("utils.venv_choice").current_julia_env(root_dir)
        end

        server_opts = vim.tbl_deep_extend("force", server_opts or {}, {
          cmd = {
            lsp_bin,
            julia_env(),
          },

          on_new_config = function(new_config, new_root_dir)
            new_config.cmd = {
              lsp_bin,
              julia_env(new_root_dir),
            }
          end,

          settings = {
            julia = {
              completionmode = "qualify",
              lint = {
                missingrefs = "all",
              },
            },
          },
        })

        vim.lsp.config(server, server_opts)
        vim.lsp.enable(server)

        return true
      end
    end,
  },
}
