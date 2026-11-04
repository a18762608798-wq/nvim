-- 把当前 Python / Julia 文件跑进一个 terminal buffer

local repl = require("utils.venv_choice")

local M = {}

-- 按文件绝对路径分别记录每个文件的运行状态：
-- runs[file] = { buf = <bufnr>, job = <jobid|nil> }
-- 同一文件重跑时杀掉旧 job/buffer 再重建；不同文件各自独立，互不影响。
local runs = {}

local function stop_run(entry)
  if entry.job then
    pcall(vim.fn.jobstop, entry.job)
    entry.job = nil
  end

  if entry.buf and vim.api.nvim_buf_is_valid(entry.buf) then
    pcall(vim.api.nvim_buf_delete, entry.buf, { force = true })
  end
  entry.buf = nil
end

-- buffer 名与文件名关联；不同文件的同名 buffer 追加序号区分
local function name_run_buffer(buf, tail)
  local ok = pcall(vim.api.nvim_buf_set_name, buf, "[Run] " .. tail)

  local n = 2
  while not ok do
    ok = pcall(vim.api.nvim_buf_set_name, buf, ("[Run] %s (%d)"):format(tail, n))
    n = n + 1
  end
end

function M.run_in_terminal_buffer(file, cmd, opts)
  opts = opts or {}

  local tail = vim.fn.fnamemodify(file, ":t")
  local entry = runs[file] or {}
  runs[file] = entry

  -- 同一文件重跑：先停掉旧 job、删掉旧 buffer
  stop_run(entry)

  -- 新建一个 buffer，用来承载 terminal
  entry.buf = vim.api.nvim_create_buf(true, true)
  vim.api.nvim_set_current_buf(entry.buf)

  -- Neovim 0.11+ 推荐用 jobstart(..., { term = true }) 替代 termopen(...)
  local job
  job = vim.fn.jobstart(cmd, {
    term = true,
    cwd = opts.cwd or repl.file_dir(),
    on_exit = function(_, code, _)
      -- 只有自然退出才清理并提示；被 stop_run 杀掉时 entry.job 已不属于本 job
      if entry.job ~= job then
        return
      end
      entry.job = nil

      vim.schedule(function()
        vim.notify(tail .. " finished with exit code " .. code, vim.log.levels.INFO)
      end)
    end,
  })

  if job <= 0 then
    vim.notify("Failed to start terminal job", vim.log.levels.ERROR)
    stop_run(entry)
    runs[file] = nil
    return
  end

  entry.job = job

  -- 必须在 jobstart 之后命名：terminal 启动时会把 buffer 名改成 term:// URI
  name_run_buffer(entry.buf, tail)

  -- 结果 buffer 保持 Normal 模式；需要交互时再按 `i` 进入终端模式。
  vim.cmd("stopinsert")
end

function M.run_current_file()
  vim.cmd("write")

  local ft = vim.bo.filetype
  local file = vim.fn.expand("%:p")

  if ft ~= "python" and ft ~= "julia" then
    vim.notify("Only python and julia files are supported", vim.log.levels.WARN)
    return
  end

  local project_dir = repl.find_project_dir()
  local cwd = project_dir or repl.file_dir()

  local cmd
  if ft == "python" then
    cmd = vim.list_extend(repl.current_python(), { file })
  else
    cmd = vim.list_extend(repl.current_julia(), { file })
  end

  M.run_in_terminal_buffer(file, cmd, { cwd = cwd })
end

return M
