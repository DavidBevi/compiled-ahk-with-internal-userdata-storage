#Requires Autohotkey v2.0

; VARIABLES -------------------------------------------------------------------------------------------------

WARNING:='THE SCRIPT HAS STRICT REQUIREMENTS FOR THE FORMAT OF THE VARIABLE "vars":' 
/* - There must be exactly 4 characters between each Key and Value
     use <<", ">>, if compiled DO NOT break lines
   - All values must have same lenght, after being compiled this lenght cannot be changed
     use asterisks to reach a lenght of 100 characters (asterisks are ignored)
*/
vars:=Map(
"notepad", "C:\Windows\System32\notepad.exe*********************************************************************",
"calculator", "C:\Windows\System32\calc.exe************************************************************************",
"onscreenkeyboard", "C:\Windows\System32\osk.exe*************************************************************************",
"defrag", "C:\Windows\System32\dfrgui.exe**********************************************************************")

for k, v in vars  ; Get the longest var
    longest:=IsSet(longest)?longest:0, longest<StrLen(v)?longest:=StrLen(v):{}
loop longest  ; Make an iterator as long as the longest var
    v:=IsSet(v)?v:0, v+=1, iter:=IsSet(iter)?iter:[], iter.Push(v)

; FUNCTIONS -------------------------------------------------------------------------------------------------

; Function to return [key, value] of a key
kv(value) {
    For key, val in vars
        val=vars[value]? kv:=[key, Trim(val,"*")]: {}
    Return kv
}

; Function to launch the selected program
run_sel(key,*)=>(Run(my_gui["e_" key].Value))

; Function to change var & make temp file
save(*) {
    sourcecode:=FileRead(A_ScriptName,"RAW")
    sourcecode_len:=sourcecode.Size

    ptr:=sourcecode.Ptr,  offset:=0

    can_proceed:="no"

    Loop sourcecode_len {
        if (can_proceed="no" and StrGet(ptr+offset,6,"UTF-8")="vars:=")
            can_proceed:="yes"
        if can_proceed="yes" {
            For k, v in vars {
                k_len:=StrLen(k)
                v:=Trim(v,"*")
                substr_of_k_len:=StrGet(ptr+offset,k_len+2,"UTF-8")
                if (substr_of_k_len='"' k '"') {
                    for i in iter {
                        char:= Ord( StrLen(my_gui["e_" k].Value)<i? "*":
                                    SubStr(my_gui["e_" k].Value,i))
                        NumPut("UChar",char,ptr+offset+k_len+5+(i-1))
                    }
                    Break
                }
            }
        }
        offset+=1
    }

    FileOpen("temp_" A_ScriptName,"w").RawWrite(sourcecode)
    Run("temp_" A_ScriptName)
    ExitApp()
}

; MAIN ------------------------------------------------------------------------------------------------------

if InStr(A_ScriptName,"temp_") {  ; If this is the TEMPORARY / INTERMEDIATE / HELPER script
    FileCopy(A_ScriptName, SubStr(A_ScriptName,6), 1)
    Run(SubStr(A_ScriptName,6))
    ExitApp

} else {                          ; If this is the MAIN / ORIGINAL / NORMAL script
    Try FileDelete("temp_" A_ScriptName)

    my_gui := Gui()
    my_gui.SetFont("s10")
    For key, val in vars {
        my_gui.AddText("x10 w120 h25 right",key)
        my_gui.AddEdit("ve_" key " x+10 w560 h25 Limit" longest,Trim(val,"*"))
        my_gui.AddButton("vb_" key " x+10 w90  h25","RUN").OnEvent("Click",run_sel.Bind(key))
    }
    my_gui.AddButton("x510 w140 h25","Cancel and exit").OnEvent("Click",(*)=>ExitApp())
    my_gui.AddButton("x+10 w140 h25","Save and reload").OnEvent("Click",save)
    my_gui.Show()
}