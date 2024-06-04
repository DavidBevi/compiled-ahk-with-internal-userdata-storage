# Goal: [saving user data inside a portable exe:](https://www.reddit.com/r/AutoHotkey/comments/1d5sahq/save_user_data_inside_compiled_exe_is_it_possible/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button)

### `v3_(current)_self_change_(arbitrary_data).ahk` / `.exe`
> [!TIP] **This is usable as a GUI that lets you run programs**
- It spawns a GUI that displays and lets you edit 4 internal variables. When you click "Save and reload" the changes are saved into an intermediate file (`temp_[original_filename]`).
- Then the original file launches the temp one and closes itself, so the changes can be saved onto the original file.
- Then the temp file launches the original one and closes itself, so the original can delete the temp.

### `v2_(old)_self_change_(fixed_data).ahk` / `.exe`
> [!NOTE] **This is just a demo**
It spawns a GUI that displays and lets you increase the byte value of 2 internal variables. Each button acts on one value and then triggers the "Save and reload" routine explained in `v3`.

### `v1_(veryold)_make_child_with_edits.exe`
> [!NOTE] **This is just a demo**
It creates a window where you can see the value of a variable and a button. If you click the button the exe generates a child where the value of the variable is changed.

### misc
For now I only found a way to do it by reading/writing the value as raw/binary, which is cumbersome. I hope to find a better solution.
