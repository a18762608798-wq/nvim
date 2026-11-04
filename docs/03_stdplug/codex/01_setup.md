# Codex 侧边栏：安装与启用

## 前提

- Linux Mint，已安装 Node.js 和 npm。
- 本配置使用 LazyVim 的 `ai.sidekick` extra，通过 `folke/sidekick.nvim` 在右侧终端运行 Codex CLI。
- 本机已完成安装和启用；2026-11-04 核对版本为 Neovim `0.12.6`、Codex CLI `0.166.0`。

## 步骤

### 1. 安装 Codex CLI

在 Bash 中检查现有安装：

```bash
command -v node npm codex
codex --version
```

需要重新安装或更新时，沿用本机的 npm 安装方式：

```bash
npm install -g @openai/codex
```

### 2. 完成 Codex 登录

已能在终端使用 Codex 的机器可以跳过登录。首次使用时，在 Bash 中执行：

```bash
codex login
```

按浏览器提示完成登录。已有其他认证方式时沿用现有设置，参见 [OpenAI 官方认证说明](https://learn.chatgpt.com/docs/auth)。

### 3. 启用 Sidekick

当前 [lazyvim.json](../../../lazyvim.json) 已包含：

```json
"lazyvim.plugins.extras.ai.sidekick"
```

迁移到其他机器时，可在 Neovim 中运行 `:LazyExtras`，找到 `ai.sidekick`；若未启用，按 `x` 启用，再安装插件：

```vim
:Lazy install sidekick.nvim
```

保留 [sidekick.lua](../../../lua/plugins/sidekick.lua) 中的本地配置，然后重启 Neovim。

## 验证

在 Neovim 中检查 CLI 路径和插件状态：

```vim
:echo exepath('codex')
:checkhealth sidekick
```

`exepath` 应返回 Codex 可执行文件路径。普通模式按 `Space aa`，应打开右侧 Codex 栏；再次按下应隐藏窗口。

若 Bash 能找到 Codex，而 Neovim 中路径为空，先从同一个已加载 Node.js/npm 环境的终端运行 `nvim`，再检查。
