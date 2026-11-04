# command

> **几乎 Pi 所有核心功能都能用，只是部分 TUI 操作换成 Neovim 命令/UI**

## neovim 命令

```text
:Pi                 " 打开 / 切换 Pi chat
:PiContinue         " 继续当前 cwd 最近一次 session
:PiResume           " 选择历史 session
:PiToggleChat       " 隐藏 / 显示 chat
:PiToggleLayout     " side / float 切换
:PiAbort            " 中断当前 Agent
:PiStop             " 真正停止后台 pi RPC

:PiAttention        " 失焦后聚焦"
:PiClearView        " 清洗当前对话历史(暂时不显示罢了)"

:PiSendMention      " 把当前文件/visual selection 引用给 Pi

:PiCycleModel       " 快速切模型
:PiSelectModel      " 选择模型

:PiCycleThinking    " 切 thinking level
:PiSelectThinking   " 选择 thinking level

:PiCompact          " compact 当前 session
```

做了这些快捷键

```json
{
  "alex35mil/pi.nvim",
  config = true,
  keys = {
    { "<leader>ip", "<cmd>Pi<cr>", desc = "Pi" },
    { "<leader>ir", "<cmd>PiResume<cr>", desc = "Pi Resume" },
    { "<leader>ic", "<cmd>PiContinue<cr>", desc = "Pi Continue" },
    { "<leader>im", "<cmd>PiSendMention<cr>", mode = { "n", "v" }, desc = "Pi Mention" },
    { "<leader>ia", "<cmd>PiAbort<cr>", desc = "Pi Abort" },
    { "<leader>il", "<cmd>PiToggleLayout<cr>", desc = "Pi Layout" },
  },
}
```

也有默认diff review快捷键:

```lua
<leader>da   接受修改
<leader>dr   拒绝修改
<leader>dn   添加 review note
<leader>dx   删除 note
<leader>dN   列出 notes
<leader>de   展开 diff 上下文
<leader>ds   缩小 diff 上下文
```

## pi 命令

可以直接使用pi的命令, 但是需要原生配置(参考pi的配置), 于是运用:

```bash
@ # file commands.
/ # slash commands
```

特别地, 你甚至可以用 `webui`
