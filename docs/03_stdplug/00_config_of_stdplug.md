# the extra function

For instance,

在 LazyVim 里：

输入命令：`:LazyExtras`

:LazyExtras 就是官方推荐的开启 extra 的方式。

进入列表后，找到 lang.python

把光标移动到 lang.python 上，按 x

这是 LazyExtras 里用来启用/禁用 extra 的键；通过 UI 打开的 extra 会被 LazyExtras 管理。

保存/退出后，LazyVim 会把这个选择记录下来；社区讨论里提到它会写到 lazyvim.json。

## Codex 侧边栏

通过 LazyVim 的 `ai.sidekick` extra 在右侧运行 Codex CLI，参见 [Codex 安装、配置与使用文档](codex/README.md)。
