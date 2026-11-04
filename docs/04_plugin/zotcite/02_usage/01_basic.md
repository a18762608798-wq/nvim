---
title: "Usage"
bibliography: references.bib
collection:
  - book
  - inbox
  - random_measurement
  - intensive
  - rough
---
## yaml 字段

- `bibliography: references.bib`
  - 指定文档使用的 BibTeX 文件。
  - `zotcite` 保存 Markdown/Quarto 文档时，会根据文中已有的引用键更新这个文件。
  - 按你当前配置，`references.bib` 是相对于当前文档目录的路径。
  - 它不是 Zotero 数据库路径；Zotero 数据库路径由 `zotero_sqlite_path` 配置。
  - 注意：该文件可能被 `zotcite` 覆盖，官方文档建议提前备份。

- `collection: ['intensive']`
  - 限制当前文档的引用补全和 `:Zseek` 搜索范围。
  - 只搜索 Zotero 中名为 `intensive` 的 collection(分类，无法路径只能写名字，同名拉倒)。
  - 多个 collection 时是合并搜索，例如：

```yaml
collection: ['intensive', 'quantum']
```

- collection 名称需要与 Zotero 中的名称匹配；不存在时会提示警告。
- 它不会自动创建 collection，也不会限制已经写入文档的引用。

简单说：

> `bibliography` 决定 BibTeX 文件写到哪里；`collection` 决定从 Zotero 哪些文献中补全引用。

## basic command

`:Zinfo`: 它会显示 Zotcite 当前识别到的数据库位置、临时目录和相关配置。出现问题时，这是首要检查命令.

`:Zseek attention`: 搜索 Zotero 文献(**attention 是某些关键字，不是命令**).

`:Zseek`: 列出collect所有文献.

## 插入模式

### 写入插入

这个模式的设置是把详细的参考资料单独放一个bib文件.

1. 首先需要设置YAML, 参考本文. YAML 中 `collection` 可以限制搜索范围.
2. 使用 `@` 写后补全即可. 例如：@Huang-Kueng-Preskill-2021, [@Huang-Kueng-Preskill-2020]

> 这个补全真心触发不灵敏，可用 `C+Z` 手动激活.

### 打开插入

`<leader>zo`: 打开插入文件.
`<leader>zi` or `<leader>za`: 显示info.

其他自己从 `<leader>z` 面板看，没有大用.

## 批注插入

### Zotero Native

`:Zannotations`: 插入全部批注到当前文档.

`:Zselectannotations`: 插入部分批注到当前文档. 回车选择，`esc` 退出.

### Other Pdf Viewer

`:Zpdfnote`: 需要安装python模块，直接安装到系统吧.

```bash
sudo apt update
sudo apt install python3-pyqt5 python3-poppler-qt5
```

效果依托.
