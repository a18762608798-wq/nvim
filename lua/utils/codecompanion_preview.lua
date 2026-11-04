-- 用 markdown-preview.nvim 在浏览器中预览 CodeCompanion chat。

local M = {}

local active_buf = nil

local function notify(message, level)
  vim.notify(message, level or vim.log.levels.INFO, { title = "CodeCompanion Preview" })
end

local function current_or_last_chat_buf()
  local current = vim.api.nvim_get_current_buf()
  if vim.bo[current].filetype == "codecompanion" then
    return current
  end

  local ok, codecompanion = pcall(require, "codecompanion")
  if not ok then
    return nil
  end

  local chat = codecompanion.last_chat()
  if chat and chat.bufnr and vim.api.nvim_buf_is_loaded(chat.bufnr) then
    return chat.bufnr
  end

  for _, item in ipairs(codecompanion.buf_get_chat()) do
    if item.chat and item.chat.bufnr and vim.api.nvim_buf_is_loaded(item.chat.bufnr) then
      return item.chat.bufnr
    end
  end

  return nil
end

local function augroup(buf)
  return vim.api.nvim_create_augroup("codecompanion_browser_preview_" .. buf, { clear = true })
end

local function clear_augroup(buf)
  pcall(vim.api.nvim_del_augroup_by_name, "codecompanion_browser_preview_" .. buf)
end

local function refresh(buf)
  if not vim.api.nvim_buf_is_loaded(buf) then
    return
  end

  pcall(vim.api.nvim_buf_call, buf, function()
    vim.fn["mkdp#rpc#preview_refresh"]()
  end)
end

local function watch(buf)
  local group = augroup(buf)

  vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
    group = group,
    buffer = buf,
    callback = function()
      refresh(buf)
    end,
  })

  vim.api.nvim_create_autocmd("BufWipeout", {
    group = group,
    buffer = buf,
    callback = function()
      if active_buf == buf then
        active_buf = nil
      end
      clear_augroup(buf)
    end,
  })
end

local function load_markdown_preview()
  local ok, lazy = pcall(require, "lazy")
  if ok then
    pcall(lazy.load, { plugins = { "markdown-preview.nvim" } })
  end
end

local function stop(buf)
  if not buf then
    return
  end

  if vim.api.nvim_buf_is_loaded(buf) then
    pcall(vim.api.nvim_buf_call, buf, function()
      vim.fn["mkdp#rpc#preview_close"]()
    end)
    vim.b[buf].MarkdownPreviewToggleBool = 0
    vim.b[buf].codecompanion_browser_preview = false
  end

  clear_augroup(buf)
  if active_buf == buf then
    active_buf = nil
  end
end

local function start(buf)
  load_markdown_preview()

  local ok, err = pcall(vim.api.nvim_buf_call, buf, function()
    vim.fn["mkdp#util#open_preview_page"]()
  end)
  if not ok then
    notify("无法启动 markdown-preview.nvim：" .. tostring(err), vim.log.levels.ERROR)
    return false
  end

  vim.b[buf].MarkdownPreviewToggleBool = 1
  vim.b[buf].codecompanion_browser_preview = true
  watch(buf)
  active_buf = buf
  notify("已在浏览器中打开 CodeCompanion 预览")
  return true
end

function M.toggle()
  local buf = current_or_last_chat_buf()
  if not buf then
    notify("没有找到 CodeCompanion chat buffer", vim.log.levels.WARN)
    return
  end

  if active_buf == buf or vim.b[buf].MarkdownPreviewToggleBool == 1 then
    stop(buf)
    notify("已关闭 CodeCompanion 浏览器预览")
    return
  end

  if active_buf and active_buf ~= buf then
    stop(active_buf)
  end

  start(buf)
end

return M
