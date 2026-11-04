# core concept

## model call distinction

* HTTP adapter: use api directly
* ACP adapter: use opencode

| 功能 | HTTP adapter（你现在） | ACP adapter |
|------|----------------------|-------------|
| `#{buffer}`, `#{diff}`, `#{selection}` 等 **Editor Context** | ✅ 可用 | ✅ 可用（实现方式不同） |
| `@{grep_search}`, `@{read_file}`, `@{insert_edit_into_file}` 等**单个 Tools** | ✅ 可用 | ❌ 不可用（Agent 有自己的工具系统） |
| `@{files}`, `@{agent}` 等 **Tool Groups** | ✅ 可用 | ❌ 不可用 |
| `@{web_search}` | ✅ 可用（需配 Tavily API key） | ❌ 不可用 |
| `/fix`, `/explain`, `/commit` 等 **Slash Commands** | ✅ 可用 | ✅ 可用 |
| 大部分 Keymaps（`ga`, `gr`, `gf` 等） | ✅ 可用 | ✅ 可用 |
| `gty`（Toggle auto-approval） | ❌ 不适用 | ✅ **仅 ACP 可用** |

---

## 核心概念：`#`、`@`、`/` 的区别

| 语法       | 名称                  | 作用                                 | 谁主动执行                       | 典型用途                                              |
| -------- | ------------------- | ---------------------------------- | --------------------------- | ------------------------------------------------- |
| `#{...}` | Editor Context      | 把 Neovim 当前状态作为上下文发给 LLM           | 你发送消息时 CodeCompanion 注入     | 当前 buffer、selection、git diff、messages、terminal 输出 |
| `@{...}` | Tools / Tool Groups | 让 LLM 可以调用工具读取、搜索、修改、运行命令          | LLM 决定是否调用，CodeCompanion 执行 | 搜文件、读文件、改文件、跑命令、看 diagnostics; HTTP adapter 使用，ACP adapter 主要由opencode自己决定使用什么工具。                     |
| `/...`   | Slash Commands      | 手动把额外内容插入 chat buffer，或执行 chat 内命令 | 你手动触发(**Insert mode to invoke**)                       | 选 buffer/file、fetch URL、compact history、加图片       |

记忆方式：

```text
# = 给模型看什么
@ = 允许模型做什么(acp 不可用, opencode有自己的权限管理系统).
/ = 我手动插入/执行什么
```
