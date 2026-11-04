-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Remove LazyVim's default spell autocmd and re-add without markdown.
vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("wrap_spell", { clear = true }),
  pattern = { "text", "plaintex", "typst", "gitcommit" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Markdown / Quarto 仅软换行，不开 spell。
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("markdown_wrap", { clear = true }),
  pattern = { "markdown", "quarto" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.breakindent = true
  end,
})

-- 当 Pyright attach 到当前 Python buffer 后，
-- 根据当前文件所在项目重新选择 Python 解释器，并通知 Pyright 更新 pythonPath。
-- 只是跟随，而非替代 lsp 配置。

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("PythonLspDynamicSettings", { clear = true }),
  desc = "Set pyright pythonPath to project Python",
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      return
    end

    if client.name ~= "pyright" and client.name ~= "basedpyright" then
      return
    end

    local python_path = require("utils.venv_choice").current_python()[1]
    if not python_path then
      return
    end

    client.config.settings = vim.tbl_deep_extend("force", client.config.settings or {}, {
      python = {
        pythonPath = python_path,
      },
    })

    client:notify("workspace/didChangeConfiguration", {
      settings = client.config.settings,
    })
  end,
})
