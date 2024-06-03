Very rough demo.

This exe creates a window where you can see the value of a variable and a button. If you click the button the exe generates a child where the value of the variable is changed. [This is why I did it.](https://www.reddit.com/r/AutoHotkey/comments/1d5sahq/save_user_data_inside_compiled_exe_is_it_possible/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button)

For now I only found a way to do it by reading / writing the value as raw / binary, which is complicate. I hope to find a better solution.



TODO: transform child in a temp exe, that is automatically launched and clones itself over the original exe. This way the original exe changes permanently to store user data.
