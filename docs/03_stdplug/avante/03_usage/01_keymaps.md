# keymaps

## bases

| 快捷键          | 功能                       |
| ------------ | ------------------------ |
| `<leader>aa` | 打开 / Ask                 |
| `<leader>at` | **隐藏侧边栏**                    |
| `<leader>an` | 新会话                      |
| `<leader>ae` | 编辑选中代码                   |
| `<leader>aS` | 停止当前请求                   |
| `<leader>af` | 切换侧边栏焦点                  |
| `<leader>aM` | 选择 **ACP/OpenCode 模型**       |
| `<leader>am` | 选择 avante models, 莫名其妙, 改成了选 **agent**|
| `<leader>ac` | 把当前 buffer 加入上下文         |
| `<leader>aB` | 加入全部打开的 buffer           |

## 侧边栏

| 按键      | 功能      |
| ------- | ------- |
| `@`     | 添加文件    |
| `d`     | 移除文件    |
| `A`     | 应用全部修改  |
| `a`     | 应用光标处修改 |
| `r`     | 重试请求    |
| `e`     | 编辑上一条请求 |
| `<Tab>` | 切换侧边栏窗口 |
| `q`     | 关闭      |

## popup window

| 按键       | 跳转位置            |
| -------- | --------------- |
| `c`      | 当前代码窗口          |
| `r`      | Avante 的回复窗口    |
| `i`      | Avante 的输入窗口    |
| `<C-w>f` | Popup 与最近窗口之间切换 |

也就是一般流程：出现权限 Popup

1. 按 c 查看正在修改的代码
2. 按 <C-w> f 返回 Popup
3. 按 y / a / n 作出决定
