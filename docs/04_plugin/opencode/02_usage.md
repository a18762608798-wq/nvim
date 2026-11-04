# usage

| 快捷键          | 功能                          |
| ------------ | --------------------------- |
| `<leader>og` | 打开 / 隐藏 OpenCode            |
| `<leader>oi` | 打开并聚焦输入框                    |
| `<leader>oI` | 新 session + 输入框             |
| `<leader>oo` | 聚焦输出窗口                      |
| `<leader>ot` | OpenCode / 编辑窗口切换焦点         |
| `<leader>os` | 选择 session                  |
| `<leader>op` | 切换 provider / model         |
| `<leader>oy` | Visual selection 加入 context |
| `<leader>od` | 打开 diff(只有在git目录才比较实用)                     |
| `<leader>o/` | Quick Chat                  |
| `<leader>oq` | 关闭 UI                       |

`<leader>od`: 只有在git根目录才能使用；
其次默认只对比修改对话前后的diff. 可以直接在修改快照旁边唤起diff.

或者配置命令:

```text
Shift-Enter    发送 prompt
Ctrl-C         取消当前请求
@              添加 mention
~              选择文件
/              slash command
#              管理 context
Tab            input/output 切换
Alt-M          build/plan 切换
Alt-R          切换 model variant
```

其中有:

- `/`: 执行 `opencode` 命令, 例如: /help /new /sessions /models /compact /undo /redo
- `@`: 调用外部对象, 例如: @file, @agent
- `#`: 调用neovim当前上下文, 例如: #selection、#diagnostics、#current_file、#diff
