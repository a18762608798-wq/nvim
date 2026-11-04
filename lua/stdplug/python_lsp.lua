-- 给 Pyright 设置启动时的默认 Python 解释器。
-- 这里先提供一个 pythonPath，避免 Pyright 启动时使用系统默认 Python。
-- 后面会在 LspAttach 事件里，根据当前 buffer 所属项目再校准一次。

return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}

      opts.servers.pyright = vim.tbl_deep_extend("force", opts.servers.pyright or {}, {
        settings = {
          python = {
            pythonPath = require("utils.venv_choice").current_python()[1],
            analysis = {
              diagnosticMode = "workspace",
              typeCheckingMode = "basic",
              diagnosticSeverityOverrides = {
                reportUndefinedVariable = "error",
                reportUnboundVariable = "error",
                reportPossiblyUnboundVariable = "warning",
              },
            },
          },
        },
      })
    end,
  },
}
