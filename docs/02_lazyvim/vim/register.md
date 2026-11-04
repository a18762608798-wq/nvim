# register

use `"` to see all the context saved.

* Unnamed register
* Named registers
* Yank registers
* Expression registers

## Unnamed registers

When we change or delte context, the banned text will be saved in unnamed register. Use `"` could to see. Choose the banned text the use `p` could to paste the context.

In other words, the context been yank will save the unnamed register acquiescently.

## Named registers

* `" (a) + yy` to record a command. `(a)` means any a character.
* `" (a) + p` to paste the context you have been saved.

## Yank registers

* `" (0) + yy` to record a command. the last yank context will be save to `0`
* `" (0) + p`
* `ctrl + r`

