# luasnip keymap

`coding.luasnip` 加载 friendly-snippets(补全选词)，短词展开后用 `Tab` 在占位符间跳转。

## 默认词

### 数学符号

| 输入 | 展开 |
| --- | --- |
| `@/` | `\frac{}{}` |
| `@2` | `\sqrt{}` |
| `@8` | `\infty` |
| `@6` | `\partial` |
| `@.` / `@*` | `\cdot` / `\times` |
| `@<` / `@>` | `\leq` / `\geq` |
| `@^` / `@_` | `\hat{}` / `\bar{}` |
| `@I` | `\int_{}^{}` |
| `__` / `**` | `_{}` / `^{}` |

### 环境

| 输入 | 生成 |
| --- | --- |
| `BEQ` / `BSEQ` | `equation` / `equation*` |
| `BAL` / `BSAL` | `align` / `align*` |
| `BIT` / `BEN` | `itemize` / `enumerate` |
| `BCAS` | `cases` |
| `BFI` / `BTA` | `figure` / `table` |

### 字体

| 输入 | 展开 |
| --- | --- |
| `FBF` / `FIT` | `\textbf{}` / `\textit{}` |
| `MBF` / `MBB` | `\mathbf{}` / `\mathbb{}` |
| `MCA` / `MRM` | `\mathcal{}` / `\mathrm{}` |

## 自定义

默认词难记就自己定义。LazyVim 自动加载 `~/.config/nvim/snippets/` 下的 VS Code 格式 snippets：

```text
~/.config/nvim/snippets/
├── package.json
└── latex.json
```

`package.json`：

```json
{
  "name": "my-snippets",
  "contributes": {
    "snippets": [
      { "language": "latex", "path": "./latex.json" }
    ]
  }
}
```

`latex.json` 示例，`$1`、`$2` 是 Tab  stops，`$0` 是结束位置：

```json
{
  "Fraction": {
    "prefix": "frac",
    "body": "\\frac{${1:numerator}}{${2:denominator}}$0",
    "description": "Fraction"
  },
  "Align": {
    "prefix": "ali",
    "body": [
      "\\begin{align}",
      "  $1",
      "\\end{align}",
      "$0"
    ],
    "description": "Align environment"
  }
}
```

重启 Neovim 后输入 `frac`，选中补全即展开，`Tab` 依次填写分子、分母。

## 建议

先用默认词（`@/`、`BAL`、`MBB` 等），觉得难记再自定义 `frac`、`ali`、`bb` 这类短词。
