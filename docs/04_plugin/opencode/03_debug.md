# debug: 快照检测问题

## 现象

在子目录启动 Neovim（例如 `cd ~/sync/theory && nvim .`），`opencode.nvim` 的快照功能（`<leader>od`）找不到 OpenCode 自己的 snapshot Git repo。

## 根因

`opencode.nvim` 把 `cwd` 同时当成"当前工作目录"和"Git worktree 根目录"。

OpenCode 1.18.31 已把两者分开：`directory` 是启动位置，`worktree` 是 Git 根。此时应为：

```text
directory = ~/sync/theory
worktree  = ~/sync
```

但插件仍用 `cwd`（即 `directory`）做两件事，所以全错：

1. snapshot 存储路径按 `cwd` 做 hash，与 OpenCode 按 `worktree` 算出的路径对不上。
2. snapshot 的 git 操作 `--work-tree` 指向子目录而非 Git 根。

## 修改

插件路径：`~/.local/share/nvim/lazy/opencode.nvim`，共改 2 个文件。

### 1. `lua/opencode/config_file.lua`

```diff
-  local worktree_hash = sha1(cwd)
+  local worktree_hash = sha1(project.worktree or cwd)
```

`project` 是上面 `get_opencode_project(cwd)` 取到的，`OpencodeProject` 自带 `worktree` 字段（见 `lua/opencode/types.lua`）。

### 2. `lua/opencode/snapshot.lua`

`snapshot_git` 的 `--work-tree` 改用 worktree：

```lua
local args = {
  'git',
  '--git-dir',
  context.snapshot_dir,
  '--work-tree',
  context.worktree or context.cwd,
}
```

`relative_path`、`checkout_or_delete`、`patch` 同理，全部从 `context.cwd` 切换到 `context.worktree or context.cwd`，并用 `vim.fs.joinpath` 替代字符串拼接。

`with_context` 内解析 worktree（注意位置，见下一节）：

```lua
if not context.worktree then
  local project_ok, project = pcall(function()
    return config_file.get_opencode_project(context.cwd):await()
  end)
  local worktree = project_ok and project and project.worktree or context.cwd
  context.worktree = canonical_path(worktree)
end
```

效果：`Space od` 仍只看当前 `theory` 目录范围（`cwd` 不变，git 命令的执行目录仍是 `cwd`），但访问 snapshot 时使用 `~/sync` 对应的正确 snapshot repo。

## 与参考方案的差异

参考方案把 `get_opencode_project(context.cwd):await()` 放在 `Promise.spawn` 之前的同步区。`Promise:await()` 只能在协程内调用，顶层同步调用会报：

```text
await() can only be called from within a coroutine
```

表现为 `tests/unit/snapshot_spec.lua` 6 个失败。因此移到了 `spawn` 内部，并用 `pcall` 包裹：取不到 project 时回退到 `cwd`，单测和离线环境不受影响。

## 验证

```bash
cd ~/.local/share/nvim/lazy/opencode.nvim
./run_tests.sh -t tests/unit/snapshot_spec.lua  # 10/10 通过
./run_tests.sh -t unit                          # 19/19 通过
```

## 注意

`Lazy update` 会覆盖 `~/.local/share/nvim/lazy/opencode.nvim` 下的手改。暂不做 patch/fork，先观察上游是否修复。
