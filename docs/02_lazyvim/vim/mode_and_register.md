# Mode

* Normal mode
* Insert mode
* Visual mode
* Ex mode: `:` start, which is the command line mode.

## Insert mode

### enter into insert mode

* `o`: enter insert mode below current line.
* `O`: enter insert mode up current line.
* `a`: enter insert mode after the cursor.
* `A`: enter insert mode at the end of the line.
* `i`: enter insert mode before the cursor.
* `I` enter insert mode at the beginning of the line.
* `c`: delte then enter into insert mode.

### operation

> These operation could also be used in terminal.

* `ctrl + ->`: move quickly.
* `ctrl + w`: delte the words.
* `ctrl + u`: delte all the words before the cursor.

## Normal mode

### single key command

* `hjkl`: move the cursor.
* `w`: move the cursor to the latter word.  
* `b`: move the cursor to the before word.
* `e`: move the cursor to the end of next word.
* `0`: move the cursor to the beginning of the line.
* `^`: move the cursor to the first characters of the line.
* `$`: move the cursor to the end of this line.
* `t`: search backward, **but not include**. Use `;` or `'` to choose.
* `f`: search backward, use `;` or `'` to choose.
* `F`: search forward.
* `y`: copy
* `p`: paste after the cursor.

### operator-pending mode

The combination is like: `operation + mode = action`

* `y` + `k`: copy the current line and the above line.
* `y` + `w` or `e`: copy the end of current **word**.
* `y` + `i` +`w`: copy the current word.
* `y` + `a` + `w`: copy the current word and the space after it.
* `y` + `10` + `l`: copy 10 characters after the cursor.
* `y` + `t` + `,`: copy until the next `,` but not including it.
* `y` + `f` + `,`: copy until the next `,`
* `Y` or `y` + `$`: copy the rest of the line.
* `y` + `3` + `y`: copy 3 lines.
* `100` + `p`: paste 100 times.
* `P`: paste before the cursor.

### browse

* `G`: move to the end of the file.
* `gg`: move to the beginning of the file.
* `100` + `j`: move down 100 lines.
* `100 + G`: move to line 100(equal to `:100`.
* `Ctrl` + `u`: move up half a page.
* `Ctrl` + `d`: move down half a page.
* `Ctrl` + `f`: move down a page.
* `Ctrl` + `b`: move up a page.

### edit

* `d`: refer to `y` for the combo.
* `c`: delte then enter into insert mode.
* `r`: replace a single character.
* `R`: similarly as insert mode of general computer.
* `>`: indent.
* `<`: cancel indent.
* `g + u`(single operation but use two characters): transfer the words to lower cases. Usually use with `a + w` and other comba.
* `g + U`: transfer the words to upper cases.
* `~`: swap uppercase and lowercase of a single character.(Could be combine with motion)
* `x`: delte single character.
* `u`: undo.
* `Ctrl` + `r`: redo.

## Visual mode

### choose

* `v` + `hjkl`: select characters.
* `v` + `o`: change the direction of selection.
* `v + p`: Replace the constituency content.
* `V`: choose a line.
* `Ctrl` + `v`: select a block, **then you can use `I` or `A` to add text to every line**.
* `V` + `>`: move the selected lines to the right.
* `*`: Choose the word be 

### use simple normal command

* `ctrl + r`

## Ex mode

### command line

Press `:` to enter command line mode, then you can input commands.

* `q`: exit neovim.
* `q!`: forcefully exit neovim without saving.
* `wq`: save and exit.
* `q:`: edit the command line history, use `enter` to run the command.
* `:1,10d`: delete lines 1 to 10.
* `:%d`: **delete all lines**. where `%` equal to `1, $`.

* `visual mode`: operation of visual range.

### shell commands

* `! + command`: To run the CIL command.

### search

Press `/` to search forward, and `?` to search backward. Then you can input the keyword.

* `enter`: start to jump to the next match.
* `n`: jump to the next match.
* `N`: jump to the previous match.
* `Esc`: cancel the search highlight.

