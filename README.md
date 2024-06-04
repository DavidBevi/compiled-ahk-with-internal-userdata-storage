# Goal: [saving user data inside a portable exe:](https://www.reddit.com/r/AutoHotkey/comments/1d5sahq/save_user_data_inside_compiled_exe_is_it_possible/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button)
This repo contains my approach, and my demos.

## a.ahk / a.exe
It creates a GUI with 2 values and 2 buttons. Each button increments the value above by one. Then the change is saved in a temporary intermediate ahk/exe, used to save the edits into the original ahk/exe. Finally the original file deletes the temp one.

## old.exe
It creates a window where you can see the value of a variable and a button. If you click the button the exe generates a child where the value of the variable is changed.

### misc
For now I only found a way to do it by reading/writing the value as raw/binary, which is cumbersome. I hope to find a better solution.
