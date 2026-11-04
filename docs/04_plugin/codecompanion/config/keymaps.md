# Keymaps

Use `?` to see all the function.

| 功能描述 | 键位（模式） | 说明 |
|----------|--------------|------|
| Change adapter and model | `ga` (Normal) | 切换 AI 适配器（如 OpenAI、Ollama）和模型（如 GPT-4） |
| Clear all messages from the chat | `gx` (Normal) | 清空当前聊天中的所有对话消息 |
| Close the chat buffer | `<C-c>` (Insert/Normal) | **关闭聊天窗口缓冲区** |
| Fold all codeblocks | `gf` (Normal) | 折叠聊天中所有代码块，只显示概要 |
| Insert an empty codeblock | `gc` (Normal) | 插入一个空的代码块语法结构 |
| Jump to the next header | `]]` (Normal) | 跳转到聊天中的下一个 Markdown 标题 |
| Jump to the previous header | `[[` (Normal) | 跳转到聊天中的上一个 Markdown 标题 |
| Open the completion menu | `<C-_>` (Insert) | 在插入模式下打开 AI 补全建议菜单 |
| Open the file path under the cursor | `gR` (Normal) | 如果光标位于文件路径上，则打开该文件 |
| Open the next chat | `}` (Normal) | 切换到下一个聊天会话 |
| Open the previous chat | `{` (Normal) | 切换到上一个聊天会话 |
| Regenerate the last response | `gr` (Normal) | 让 AI 重新生成最后一条回复 |
| Remove rules from the chat | `gM` (Normal) | 移除当前聊天中附加的自定义规则 |
| Reset cached tool approvals | `gtx` (Normal) | 清除已记住的工具调用批准记录，再次调用时需重新确认 |
| Send the message to the LLM | `<C-s>` (Insert), `<CR>`/`<C-s>` (Normal) | 将当前输入的消息发送给 AI 模型 |
| Show Copilot usage statistics | `gS` (Normal) | 显示 GitHub Copilot 使用量统计（如果启用） |
| Show debug info for the chat | `gd` (Normal) | 显示当前聊天会话的调试信息 |
| Stop the current request | `q` (Normal) | 中断正在进行的 AI 请求 |
| Toggle auto-approval of tool calls | `gty` (Normal) | 开启/关闭自动批准工具调用（例如文件读写） |
| Toggle diff-only syncing of pinned buffers | `gbd` (Normal) | 切换“仅同步差异内容”到固定缓冲区的模式 |
| Toggle live-syncing of pinned buffers | `gba` (Normal) | 切换实时同步固定缓冲区内容的开关 |
| Toggle the system prompt on/off | `gs` (Normal) | 开启/关闭系统提示（即每次对话开头注入的指令） |
| Yank code from the last codeblock | `gy` (Normal) | 复制聊天中最后一个代码块的内容到剪贴板 |

具体来说，

* `gty`: Only ACP could be used.

自定义的keymap有：

1. `ac`: 打开当前chat.
2. `ai`: inline.
3. `an`: 新建chat, write prompt.
4. `ap`: quick action(must be used in chat window.
