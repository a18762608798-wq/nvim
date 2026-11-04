# installization

## Introduction

Neovim 的配置使用 Lua 描述。vim 配置使用 Vimscript 描述。

## The fundational tools to download

* Neovim
* Lazy.nvim
* git
* nodejs
* npm

To download Neovim, in web we download on: `https://github.com/neovim/neovim/blob/master/INSTALL.md#ubuntu`

```bash
# firstly install the reps
# bases
sudo apt update
sudo apt install -y software-properties-common
sudo add-apt-repository -y ppa:git-core/ppa
sudo apt update
sudo apt install -y \
  xclip \
  git \
  ripgrep \
  python3-dev \
  python3-pip \
  python3-venv \
  fd-find \
  curl \
  build-essential \
  sqlite3

# rust
sudo apt install -y tmux
# javasricpt
# nvm(uv, conda)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
source ~/.bashrc
command -v nvm
nvm --version
# npm(pip+venv), node(python3)
# `nvm install --lts` 这一步会下载并安装 **Node.js**，而 npm 随 Node.js 捆绑发布，所以 **npm 也一并装好了**。
nvm install --lts
nvm alias default 'lts/*' # 将 nvm 的默认 Node.js 版本设置为最新的 LTS（长期支持）版本
node --version
npm --version
# pnpm(高级uv)
npm install -g pnpm # Node.js 22 及以上：安装当前最新 pnpm

# the install the neovim
tar xzvf nvim-linux-x86_64.tar.gz
./nvim-linux-x86_64/bin/nvim --version
# when all are normal, mv to a format position:
sudo mv nvim-linux-x86_64 /opt/nvim
sudo ln -sf /opt/nvim/bin/nvim /usr/local/bin/nvim
# then f5
nvim --version
which nvim
```

Then we clone the lua folder(当然现在我们可以用我们自己的了):

```bash
mkdir -p ~/.config
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git
nvim
```

如果是win的话目录有所不同

```bash
mkdir $env:LOCALAPPDATA\nvim
```

而且win还有对c的要求 `winget install -e --id BrechtSanders.WinLibs.POSIX.UCRT`

## the configs folder

To see the structure of the config folder, we install via `sudo apt install tree`

```bash
.
├── init.lua # entrance
├── lazy-lock.json # record the plugins, self-command.
├── lazyvim.json
├── LICENSE
├── lua
│   ├── config
│   │   ├── autocmds.lua
│   │   ├── keymaps.lua
│   │   ├── lazy.lua
│   │   └── options.lua
│   └── plugins
│       └── example.lua
├── README.md
└── stylua.toml
```

主要修改这两个文件的配置：

* lua/config/options.lua：编辑器行为
比如缩进、行号、是否使用系统剪贴板、搜索高亮、鼠标、tab 宽度之类。官方也说明 options.lua 会自动加载。

> NOTICE:
> If you intend to set clipboard, you must get the support of this system,

```bash
echo $XDG_SESSION_TYPE
sudo apt install xclip # If the result is xclip.
sudo apt install wl-clipboard # If the result is wayland.
```

* lua/config/keymaps.lua：快捷键
比如你想改保存、切窗口、找文件、退出终端、删除默认映射，主要都放这里。官方也明确说全局按键映射就在这个文件里配。
