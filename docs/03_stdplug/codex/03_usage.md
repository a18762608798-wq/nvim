# Codex 侧边栏：日常使用

## 前提

已完成 [安装](01_setup.md) 和 [配置](02_config.md)。`<leader>` 是空格；下文的 `Space aa` 表示先按空格，再依次按 `a`、`a`。

## 内容

### 常用快捷键

| 按键 | 使用位置或模式 | 功能 |
| --- | --- | --- |
| `Space aa` | 普通模式 | 打开或隐藏 Codex 栏，隐藏时保留进程 |
| `Ctrl+.` | 代码窗口 | 打开 Codex 栏并聚焦 |
| `Ctrl+.` | Codex 栏内 | 隐藏侧栏 |
| `Ctrl+h` | Codex 终端输入模式 | 回到左侧代码窗口，保持侧栏可见 |
| `Space at` | 代码窗口，普通或可视模式 | 发送当前文件的位置或选区范围引用 |
| `Space af` | 代码窗口，普通模式 | 发送当前文件路径引用 |
| `Space av` | 代码窗口，可视模式 | 发送选中的文本内容 |
| `Space ap` | 普通或可视模式 | 打开 Sidekick 提示词列表，选择解释、修复等任务 |

`Space ap` 沿用 LazyVim 默认行为；先用 `Space aa` 打开 Codex，再选择提示词。

### 发送文件或选区

1. 在项目目录启动 `nvim`，打开要处理的文件。
2. 先用 `:w` 保存；`Space af` 和文件中的 `Space at` 传入路径、位置引用，Codex 读取磁盘文件。
3. 按 `Space af` 发送文件引用；若只需讨论几行，用 `V` 选中后按 `Space av` 发送文本。
4. 在 Codex 输入区补充任务，例如：`解释这个文件的主要逻辑，用中文回答。`
5. 按 `Enter` 提交；完成后按 `Ctrl+h` 回到代码窗口检查结果。

上下文快捷键会先把内容放入 Codex 输入区，供你补充要求后提交。未保存的选区文本可通过 `Space av` 发送；需要 Codex 读取整个文件时先保存。

### 在终端模式与普通模式之间切换

Codex 栏是 Neovim terminal buffer。输入模式下，字母和空格会交给 Codex；要执行 `Space aa` 等普通模式快捷键，先按 `Ctrl+q` 进入终端普通模式。

- 终端普通模式按 `i`：恢复向 Codex 输入。
- 终端普通模式按 `q`：隐藏侧栏，保留进程。
- 普通模式按 `Space ad`：关闭或分离 CLI；当前未启用 mux，关闭 Codex 终端会结束该进程。

### 新建与恢复会话

以下命令输入在 Codex 栏中，并按 `Enter` 执行：

| 命令 | 功能 |
| --- | --- |
| `/new` | 新建会话 |
| `/resume` | 选择已保存的会话并继续 |
| `/model` | 选择当前会话的模型 |
| `/status` | 查看当前会话状态 |
| `/diff` | 在 Git 项目中查看工作区改动 |

参见 [OpenAI 官方命令说明](https://learn.chatgpt.com/docs/developer-commands?surface=cli)。

`Space aa` 和 `q` 只隐藏窗口；关闭进程或退出 Neovim 后，需要恢复历史会话时，重新打开 Codex 栏并使用 `/resume`。

也可以在项目目录的 Bash 中恢复最近的会话：

```bash
codex resume --last
```

该命令启动独立的终端 CLI；若要在 Neovim 侧栏继续，使用侧栏中的 `/resume`。

## 验证

打开一个已保存的文件，按 `Space aa`，确认 Codex 栏在右侧出现。按 `Ctrl+h` 回到代码区，选择几行并按 `Space av`，检查输入区包含选区内容；补充问题后按 `Enter`。

再隐藏并重新打开侧栏，确认当前会话仍在。若 `Ctrl+.` 被外层终端拦截，使用普通模式的 `Space aa` 开关侧栏。
