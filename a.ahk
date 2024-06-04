#Requires Autohotkey v2.0

; Define the variables
vars := Map(
"var_a", "A",
"var_b", "B")

; Function to get if this script is the orig or temp file
thiz:= InStr(A_ScriptName,"temp_")? "temp": "orig"

; Function to return [key, value] of a key
kv(value) {
    For key, val in vars
        val=vars[value]? kv:=[key, val]: {}
    Return kv
}


; Functions to make & show GUI
if thiz="temp" {
    FileCopy(A_ScriptName, SubStr(A_ScriptName,6), 1)
    Run(SubStr(A_ScriptName,6))
    ExitApp
} else {
    Try FileDelete("temp_" A_ScriptName)
    my_gui := Gui()
    my_gui.SetFont("s12")
    my_gui.AddEdit("x12 w30",kv("var_a")[2])
    my_gui.AddEdit("x+12 w30",kv("var_b")[2])
    my_gui.AddButton("vEditA x12 w30","+").OnEvent("Click", make_temp.Bind("var_a"))
    my_gui.AddButton("vEditB x+12 w30","+").OnEvent("Click", make_temp.Bind("var_b"))
    my_gui.Show()
}

; Function to change var & make temp file
make_temp(var, *) {
    flag:=0
    k:=kv(var)[1],  klen:=StrLen(k)
    v:=kv(var)[2],  vlen:=StrLen(v)

    sourcecode:=FileRead(A_ScriptName,"RAW")
    sourcecodelen:=sourcecode.Size
    offset:=0
    ptr:=sourcecode.Ptr+offset

    Loop sourcecodelen {
        substr_of_klen:=StrGet(ptr+offset,klen,"UTF-8")
        if (substr_of_klen=k and flag=0) {
            curv:=NumGet(ptr+offset+klen+4,"UChar")
            newv:=curv+1
            NumPut("UChar",newv,ptr+offset+klen+4)
            flag := 1
        } else {
            offset += 1
        }
    }

    FileOpen("temp_" A_ScriptName,"w").RawWrite(sourcecode)
    o:=MsgBox("Done!"), o="ok"? (Run("temp_" A_ScriptName), ExitApp()): {}
}