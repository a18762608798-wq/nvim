# Codex 侧边栏：配置说明

## 前提

已完成 [安装与启用](01_setup.md)。这里的侧边栏由 LazyVim Sidekick 提供，运行的是本机 `codex` CLI。

## 内容

### 配置入口

| 文件 | 作用 |
| --- | --- |
| [lazyvim.json](../../../lazyvim.json) | 启用 `lazyvim.plugins.extras.ai.sidekick` |
| [sidekick.lua](../../../lua/plugins/sidekick.lua) | 右侧布局、关闭 NES、将常用快捷键指向 Codex |
| [opencode.lua](../../../lua/plugins/opencode.lua) | 用 `enabled = false` 停用原 OpenCode 侧边栏 |
| [lazy-lock.json](../../../lazy-lock.json) | 记录实际安装的 Sidekick 版本 |

虽然文档归在 `03_stdplug`，本地覆盖配置实际放在 `lua/plugins/sidekick.lua`，无需在 `lua/stdplug/` 再声明一份。

### 最小配置

启用 extra 后，以下是本地覆盖的最小示例；完整快捷键以现有 `sidekick.lua` 为准：

```lua
return {
  {
    "folke/sidekick.nvim",
    opts = {
      nes = { enabled = false },
      cli = {
        win = { layout = "right" },
      },
    },
    keys = {
      { "<tab>", false },
      {
        "<leader>aa",
        function()
          require("sidekick.cli").toggle({ name = "codex", focus = true })
        end,
        desc = "Toggle Codex",
      },
    },
  },
}
```

- `nes.enabled = false`：关闭 Copilot Next Edit Suggestions。
- `{ "<tab>", false }`：移除此 extra 的 Tab 映射，保留原有 Tab 行为。
- `cli.win.layout = "right"`：在右侧分屏打开 CLI。
- `name = "codex"`：直接打开 Codex，跳过其他 CLI 的选择列表。

需要调整宽度时，在 `cli.win` 中增加 `split = { width = 80 }`；`80` 表示列数。

### 登录与模型配置

Sidekick 默认执行 `codex`，本地 Lua 配置没有指定模型或注入 API key。登录、模型和 MCP 等设置沿用 Codex 自身配置。

个人配置默认位于 `~/.codex/config.toml`；项目可以使用 `.codex/config.toml` 覆盖部分设置，项目层配置需先信任该项目。参见 [OpenAI 官方配置说明](https://learn.chatgpt.com/docs/config-file/config-basic)。

在 Codex 栏输入 `/model` 可选择当前会话的模型，输入 `/status` 查看会话状态，参见 [官方命令说明](https://learn.chatgpt.com/docs/developer-commands?surface=cli)。

## 验证

重启 Neovim，按 `Space aa`，确认直接进入右侧 Codex 栏。侧边栏的登录和模型应与终端直接运行 `codex` 时的对应配置一致。

需要检查当前快捷键来源时，在代码窗口普通模式执行：

```vim
:verbose nmap <leader>aa
```
