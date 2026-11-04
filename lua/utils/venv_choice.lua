-- 判断当前项目该用哪个 Python / Julia。

local M = {}

local python_cache = {}

local function resolve_start_dir(arg)
  if type(arg) == "string" then
    return arg
  end
  if type(arg) == "table" and arg.current_bufnr then
    local bufname = vim.api.nvim_buf_get_name(arg.current_bufnr)
    if bufname ~= "" then
      return vim.fs.dirname(bufname)
    end
  end
  return vim.fn.expand("%:p:h")
end

function M.find_project_dir(start_dir)
  if type(start_dir) ~= "string" or start_dir == "" then
    start_dir = vim.fn.expand("%:p:h")
  end

  if start_dir == "" then
    start_dir = vim.fn.getcwd()
  end

  local project = vim.fs.find("Project.toml", {
    path = start_dir,
    upward = true,
  })[1]

  if project then
    return vim.fs.dirname(project)
  end

  return nil
end

function M.file_dir()
  return vim.fn.expand("%:p:h")
end

function M.current_python()
  local venv = vim.env.VIRTUAL_ENV or vim.env.CONDA_PREFIX

  if venv and venv ~= "" then
    local py = venv .. "/bin/python"
    if vim.fn.executable(py) == 1 then
      return { py }
    end
  end

  local project_dir = M.find_project_dir()

  if project_dir then
    if python_cache[project_dir] then
      return { python_cache[project_dir] }
    end

    -- 先探测 CondaPkg 的固定安装位置：一次 stat，避免同步拉起 Julia（实测数秒）
    for _, py in ipairs({
      project_dir .. "/.CondaPkg/.pixi/envs/default/bin/python",
      project_dir .. "/.CondaPkg/env/bin/python",
    }) do
      if vim.fn.executable(py) == 1 then
        python_cache[project_dir] = py
        return { py }
      end
    end

    local result = vim
      .system({
        "julia",
        "--project=" .. project_dir,
        "--startup-file=no",
        "-e",
        'using CondaPkg; print(CondaPkg.which("python"))',
      }, { text = true })
      :wait()

    if result.code == 0 then
      local py = vim.trim(result.stdout)
      if py ~= "" and vim.fn.executable(py) == 1 then
        python_cache[project_dir] = py
        return { py }
      end
    end

    -- 失败也按项目缓存（会话内有效），否则每次调用都重新拉起 Julia，卡数秒
    python_cache[project_dir] = "python3"
    return { "python3" }
  end

  return { "python3" }
end

function M.current_julia_env(start_dir)
  local julia_project = vim.env.JULIA_PROJECT

  if julia_project and julia_project ~= "" and julia_project ~= "@." then
    local path = vim.fn.expand(julia_project)

    if vim.fn.filereadable(path) == 1 then
      return vim.fs.dirname(path)
    end

    return path
  end

  local project_dir = M.find_project_dir(start_dir)

  if project_dir then
    return project_dir
  end

  return vim.fn.expand("~/.julia/environments/v1.12")
end

function M.current_julia(arg)
  local start_dir = resolve_start_dir(arg)
  return { "julia", "--project=" .. M.current_julia_env(start_dir) }
end

return M
