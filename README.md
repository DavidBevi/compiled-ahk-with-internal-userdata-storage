# Goal: [saving user data inside a compiled AHK script](https://www.reddit.com/r/AutoHotkey/comments/1d5sahq/save_user_data_inside_compiled_exe_is_it_possible/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button)
And I mean directly, using no config-files, no reg-edits, nothing outside the exe.

## v3 (current): Internally store arbitrary strings
> [!TIP]
> **This can be used as a launchboard.** [`Download .ahk`](https://github.com/DavidBevi/compiled-ahk-with-internal-userdata-storage/blob/main/v3_(current)_self_change_(arbitrary_data).ahk) / [`Download .exe`](https://github.com/DavidBevi/compiled-ahk-with-internal-userdata-storage/blob/main/v3_(current)_self_change_(arbitrary_data).exe)

>  [!WARNING]
> - Your antivirus my detect/delete my program. I pinky-promise it's not malicious (if you don't believe me just look at the code :smile:)
> - Please be also aware that by its very nature this code is able to corrupt itself, it will probably do it as soon as you steer from the suggested use case.

> :gear: **How it works**
> 
> This program consists in a window that displays and lets you edit 4 internal variables. When you click "Save and reload":
> - a temporary intermediate file (`temp_[original_filename]`) is made to store the changes;
> - the original file launches the temp one and closes itself, so the changes can be saved onto the original file;
> - the temp file launches the original one and closes itself, so the original can delete the temp.

## Older demos
> ### `v2_(old)_self_change_(fixed_data).ahk` / `.exe`
> - It spawns a GUI that displays and lets you increase the byte value of 2 internal variables. The 2 buttons act on one value each, then they trigger the "Save and reload" routine explained in `v3`.
> 
> ### `v1_(veryold)_make_child_with_edits.exe`
> - It spawns a GUI that displays a variable and a button. If you click the button the exe spawns a child exe where the value of the variable is changed. The child should do the same, but the code is broken :stuck_out_tongue_closed_eyes:

### Misc
For now I only found a way to do it by reading/writing the value as raw/binary, which is cumbersome. I hope to find a better solution.

Please feel free to do what you want with my files.
