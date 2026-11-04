# AGENTS.md — Neovim 配置

## 概述

LazyVim v8 的 Neovim 配置，基于 lazy.nvim 插件管理器。面向 Python 和 Julia 的日常开发。

## 目录约定

| 路径 | 用途 |
|------|------|
| `lua/config/` | options、keymaps、autocmds、lazy 启动 |
| `lua/plugins/` | 插件声明（lazy.nvim spec） |
| `lua/utils/` | 纯 Lua 工具库，不声明插件 |

## 关键命令

| 用途 | 命令 |
|------|------|
| Lua 格式化 | `stylua .` |
| 插件同步 | 在 Neovim 内 `:Lazy sync` |
| 插件更新检查 | `:Lazy check` |

## 架构要点

- **启动入口**: `init.lua` → `require("config.lazy")`，lazy.lua 负责 bootstrap lazy.nvim 并加载 LazyVim 及自定义 plugins。
- **Color scheme**: `cyberdream`（`lua/plugins/colorscheme.lua`），覆盖 LazyVim 默认的 tokyonight，背景强制为 `#000000`。
- **Leader**: `<Space>`，localleader: `\`。
- **缩进**: 4 空格（tabstop=4, shiftwidth=4），stylua 格式化为 2 空格（仅 Lua 源码）。

## 环境检测

`lua/utils/venv_choice.lua` 提供 Python/Julia 环境自动检测：

- **Python 解释器**：优先级 VIRTUAL_ENV > CONDA_PREFIX > 项目 `.CondaPkg` 固定路径探测（`.pixi/envs/default/bin/python`，纯 stat，无子进程）> 同步 Julia CondaPkg 查询（结果含失败均按项目缓存，避免重复拉起 Julia）> 系统 `python3`。
- **Julia 项目**：优先级 JULIA_PROJECT 环境变量 > 向上查找 `Project.toml` > `~/.julia/environments/v1.12`。

## AI 补全与对话

- **sidekick.nvim** (`lua/plugins/sidekick.lua`):
  - 通过 LazyVim `ai.sidekick` extra 启用，在右侧 terminal 中运行本机 `codex` CLI，沿用 Codex 自身的登录和模型配置。
  - `<leader>aa` 开关 Codex 侧边栏，`<C-.>` 切换焦点。
  - `<leader>at` 发送当前位置上下文，`<leader>af` 发送当前文件路径，可视模式 `<leader>av` 发送选区。
  - 禁用 Copilot NES，保留原有 Tab 行为。
  - 原 `opencode.nvim`、`codecompanion.nvim` 和 `avante.nvim` 侧边栏均已禁用。
- **minuet-ai.nvim** (`lua/plugins/minuet.lua`):
  - 内联补全，provider 为 `openai_compatible`，指向 OpenCode Go 免费端点
    `https://opencode.ai/zen/go/v1/chat/completions`，模型 `deepseek-v4-flash`，使用 `OPENCODE_API_KEY` 认证。
  - `/go/` 路径不可省略：付费端点 `/zen/v1/` 在无余额时返回 401。
  - 已通过 `optional.thinking` 禁用推理输出（避免 `reasoning_content` 污染补全）。
  - 通过 blink.cmp 集成，自动触发，且 `<A-y>` 手动强制触发。

## Python / Julia 开发工具

- **LSP**: Pyright（Python，含从 venv_choice 自动校准 pythonPath）、Julia LSP（通过 mason 安装，`@lsp.type` 提供更新机制，不通过 mason 管理）。
- **REPL**: iron.nvim，Python/Julia REPL 均通过 `venv_choice` 确定启动命令。
- **Quarto / Markdown**: quarto-nvim + otter.nvim，Quarto 代码块（`{python}`/`{julia}`）和普通 Markdown 代码块（`python`/`julia`）均使用 iron 作为 runner；Markdown 通过标准 fenced-code 注入规则激活 Otter。
- **代码运行**: `<leader>rf` 将当前 Python/Julia 文件在 terminal buffer 中执行。

## LazyVim Extras

在 `lazyvim.json` 启用的 extras: `ai.sidekick`, `luasnip`, `yanky`, `json`, `julia`, `markdown`, `python`, `toml`。

## 格式规则

- **Lua**: stylua（2 空格缩进，120 列宽）。
- **Markdown**: markdownlint-cli2，配置文件为仓库根目录的 `.markdownlint.yaml`。
- **LSP 补全**: lua_ls 通过 `.neoconf.json` 启用 neodev 插件类型检测。
