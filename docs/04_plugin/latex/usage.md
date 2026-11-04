# usage

## basic

```text
nvim main.tex

\ll    开始持续编译

写作
:w

\lv    看当前源码在 PDF 中的位置

Zathura Ctrl+左键
       回源码

\lk    停止 latexmk
```

## coding.luasnip

`coding.luasnip` 提供短词展开 + `Tab` 跳转，后端是 LuaSnip + friendly-snippets。

### latex

常用词见 `luasnip_keymap.md`，例如 `@/` 展开 `\frac{}{}`，`BAL` 展开 `align` 环境。

### markdown

| 输入 | 展开 |
| --- | --- |
| `3x1table` | 3 列 1 行表格 |
| `task3` | 3 项任务列表 |
| `link` | `[text](url)` |

输入后在补全菜单选中即可，`Tab` 在占位符之间跳转。
