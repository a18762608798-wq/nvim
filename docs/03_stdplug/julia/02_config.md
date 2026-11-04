# config

The main configs consists of two files: julia and quarto.

The configs files ref to:

* `~/.config/nvim/lua/plugins/quarto.lua` , use to config quarto plugin.
* `~/.config/nvim/lua/plugins/iron.lua` , use to set the keymaps to sent code to terminal in quarto.
* `~/.config/nvim/lua/utils/code_runner.lua` , use to create terminal to run julia and python code.
* `~/.config/nvim/lua/utils/repl.lua.lua` , use to choose the environment to run code.
* `~/.config/nvim/lua/plugins/julia_lsp.lua`, use to source lsp.

Mason 的 julia-lsp 工作原理：

* 下载 Julia VS Code 扩展的完整包，其中包含预编译好的 LanguageServer 及其所有依赖
* 自带独立包仓库 store/lsdepot/v1，无需 Pkg.add("LanguageServer")
* 接收 julia_env() 返回的环境路径作为参数（与我们的 cmd 配置一致）

配置修改（julia_lsp.lua）：

* 去掉两处 mason = false，让 Mason 自动管理
* 去掉无用的 before_init = function() end
* 删除手动创建的包装脚本
重启 Neovim，打开 .jl 文件即可触发 LSP。首次启动需预编译，等待几十秒后 :LspInfo 可确认 julials 已附加。。

具体俺还装路径是 `~/.local/share/nvim/mason/packages/julia-lsp/libexec/extension/scripts/packages/`
