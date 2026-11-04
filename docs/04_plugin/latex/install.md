# install

## backend support

检测相关环境:

```bash
nvim --version
latexmk -v
pdflatex --version
xelatex --version
lualatex --version
synctex version
```

其中比较重要的是安装latex后端:

```bash
sudo apt update
sudo apt install texlive-full
```

## 安装PDF支持

```bash
sudo apt update
sudo apt install zathura zathura-pdf-poppler
```

检查:

```bash
zathura --version
```

## nvim

Ref to [latex.lua]
