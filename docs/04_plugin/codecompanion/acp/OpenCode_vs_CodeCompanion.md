# OpenCode 在 CodeCompanion 下的行为变换

CodeCompanion 通过 ACP adapter 连接 opencode 作为后端。以下是 opencode 原生能力在 CodeCompanion 包装层下的行为对照。

---

## 架构概览

```
输入层 (CodeCompanion)         执行层 (opencode)
─────────────────────         ──────────────────
#{}  Editor Context    →  注入到 prompt（opencode 视为用户消息的一部分）
/...  Slash Commands   →  CodeCompanion 本地处理
@{...} Tools           →  不可用 — opencode 自己决定用什么工具
Keymaps                →  CodeCompanion buffer 层操作
```

---

## `#{}`：Editor Context → opencode prompt

CodeCompanion 在发送前将 `#{}` 替换为实际内容，opencode 收到的是已展开的文本。

| CodeCompanion 语法 | 传给 opencode 的内容 | 等价于在 opencode CLI |
|---|---|---|
| `#{buffer}` | 当前文件完整内容 | `@文件名` 的效果 |
| `#{buffer}{diff}` | 当前文件 git diff | 无直接等价，需手动贴 diff |
| `#{buffers}` | 所有打开 buffer 内容 | 无直接等价 |
| `#{selection}` | 当前 visual selection | 选中后直接发送 |
| `#{diff}` | git diff（工作区） | `git diff` |
| `#{messages}` | `:messages` 输出 | 无直接等价 |
| `#{diagnostics}` | LSP diagnostics | 无直接等价 |
| `#{terminal}` | 终端 buffer 输出 | 无直接等价 |

**结论**：`#{}` 是 CodeCompanion 独有的上下文注入能力，opencode CLI 没有等价语法，但效果可通过手动粘贴达到。

---

## `@{...}`：Tools → 不可用

AC adapter 下 CodeCompanion 的 `@{...}` 工具全部失效，因为 opencode 自带完整的工具系统。

**要点**：AC adapter 下，不要写 `@{...}`，直接描述意图即可。opencode 会自动选择合适的工具。

---

## `/`：Slash Commands

### CodeCompanion 本地命令（ACP 下也可用）

| 命令 | 功能 |
|---|---|
| `/buffer` | 选 buffer 加入上下文 |
| `/file` | 选文件加入上下文 |
| `/fetch` | 拉取 URL 内容 |
| `/symbols` | 当前文件结构概览 |
| `/image` | 插入图片 |
| `/now` | 插入当前时间 |
| `/help` | 插入 Vim help |
| `/rules` | 管理规则组 |
| `/mcp` | 管理 MCP server |
| `/share` | 分享为 GitHub Gist |

### ACP 专用命令

| 命令 | 功能 |
|---|---|
| `/command ...` | 切换acp作用，对我们无用. |
| `/resume` | **恢复之前的会话(类似选择对话), 但是没有提供删除选项，只能用opencode CIL 或者命令行session list 和 session delete <sessionID>** |
| `/acp_session_options` | ACP 会话选项(mode,...) |

---

## `\`：try to us Slash Commands in opencode CIL

`\` + command, but some command could be used.

## Keymaps 行为差异

### ACP 独有键位

| 键位 | 功能 | 说明 |
|---|---|---|
| `gty` | 切换自动批准工具调用 | 仅 ACP 可用，HTTP 模式无意义 |

### opencode TUI 内置键位 vs CodeCompanion 键位

CodeCompanion 的 chat buffer 有自己的 keymaps，这些不会传递到 opencode TUI：

| 功能 | opencode TUI | CodeCompanion chat |
|---|---|---|
| 切换 agent (Plan/Build) | `Tab` | `acp_session_options` to choose mode |
| @ 文件引用 | `@文件名` 模糊搜索 | `#{buffer:文件名}` |
| 拖入图片 | 拖入终端 | `/image` |
| 发送消息 | `Enter` | `<C-s>` 或 `<Enter>` |
| 中断请求 | `Ctrl+C` | `q` |
| 撤销 | `/undo` | `/command /undo` |

> 有些命令比如/compact后续会被opencode自动特殊处理.
---

## 适配器切换

| 功能 | HTTP 适配器 | ACP 适配器 |
|---|---|---|
| 工具调用方式 | `@{tool_name}` 手动声明 | 直接描述，opencode 自动选工具 |
| 文件编辑 | `@{insert_edit_into_file}` | 自动使用 edit/write |
| Web 搜索 | `@{web_search}` (需 Tavily) | opencode 内置 `webfetch`/`websearch` |
| 对话管理 | CodeCompanion 自己管理 | opencode 管理（可 resume） |
| 自动批准 | **`gtx` 重置缓存批准** | `gty` 切换自动批准 |
| prompt library | `/fix`, `/explain`, `/tests` 等 | 同上，都可用 |

---

## 最佳实践

使用 ACP adapter (opencode) 时：

1. **不说 `@{tools}`** — opencode 会自己决定用什么工具
2. **善用 `#{}`** — 把 Neovim 上下文传给 opencode
3. **用 `gty`** — 开启自动批准可减少每次工具调用的确认
4. **用 `/command` 转发** — 执行 opencode 的原生命令如 `/undo`、`/diff`
5. **直接自然语言描述** — 像用 opencode CLI 一样对话，不需要特殊语法
