'Form created with the help of Freeform 3 v03-27-03
'Generated on Apr 27, 2009 at 18:58:14
'Created by: Markus Tolin for MUAGS

'definations
open "mesock32.dll" for dll as #me
global connect
global rec$
global handle
global text$
global PlayerLocX
global PlayerLocY
global cmd
global dummy$
GLOBAL PORT
GLOBAL map1$
GLOBAL maplist$
GLOBAL VERSION$
GLOBAL address$
global fail
dim info$(10, 10)
dim dummy$(1000)
dim map1$(1000,1000)
dim maplist$(1000)
dim playerData$(1000,1000)
connect = 0
fail = 0

configDir$ = DefaultDir$ + "\data\"
mapDir$ = configDir$ + "maps\"


'file checks for the important files
if fileExists(configDir$, "config.conf") then
    'goto [conf.read]
  else
    notice "Error!" + chr$(13) + "\data\config.conf is missing, client cannot be started!"
    goto [quit.main2]
  end if
if fileExists(mapDir$, "maps.list") then

  else
    notice "Error!" + chr$(13) + "\data\maps\maps.list is missing, client cannot be started!"
    goto [quit.main2]
  end if

ConfigFile$ = configDir$ + "config.conf"

[conf.read]
    open ConfigFile$ for input as #conf
        line input #conf, VERSION$
        line input #conf, address$
        line input #conf, port$
    close #conf
    PORT = val(port$)

mapFile$ = mapDir$ + "maps.list"

[map.list.read]
    s = 0
    open mapFile$ for input as #maplist
[map.list.loop]
    s = s + 1
    input #maplist, maplist$(s)
    if eof(#maplist) = 0 then [map.list.loop]
[map.list.skipIt]

    close #maplist

'program starts here

[setup.main.Window]

    '-----Begin code for #main

    nomainwin
    WindowWidth = 1024
    WindowHeight = 768
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)


    '-----Begin GUI objects code

    TexteditorColor$ = "white"
    texteditor #main.mainview,   5,   5, 900, 680
    TextboxColor$ = "white"
    textbox #main.input,   5, 692, 900,  25
    button #main.button1,"1",[button1Click], UL, 910,   5,  17,  25
    button #main.button2,"2",[button2Click], UL, 910,  35,  17,  25
    button #main.button3,"3",[button3Click], UL, 910,  65,  17,  25
    button #main.button4,"4",[button4Click], UL, 910,  95,  17,  25
    button #main.button5,"5",[button5Click], UL, 910, 125,  17,  25
    button #main.button6,"6",[button6Click], UL, 910, 155,  17,  25
    button #main.button7,"7",[button7Click], UL, 910, 185,  17,  25
    button #main.button8,"8",[button8Click], UL, 910, 215,  17,  25
    button #main.button9,"9",[button9Click], UL, 910, 245,  17,  25
    button #main.button0,"0",[button0Click], UL, 910, 275,  17,  25

    '-----End GUI objects code

    '-----Begin menu code

    menu #main, "Game",_
                "Connect"   , [open.connect],_
                "Disconnect", [disconnect],|,_
                "Quit"      , [quit.main]

    menu #main, "Help",_
                "Help" , [open.help],_
                "About", [open.about]

    menu #main, "Settings",_
                "Settings", [open.settings]

    menu #main, "Edit"  ' <-- Texteditor menu.


    '-----End menu code

    open "Muags client" for window as #main
    print #main, "font ms_sans_serif 10"
    print #main, "trapclose [quit.main]"


[main.inputLoop]   'wait here for input event
    wait


[game.main.loop]    'main loop after connection is succesful
    scan
    if connect = 1 then
        let rec$ = ""
        let rec$ = TCPReceive$(handle)
        if rec$ <> "" then
            ad = CheckData(rec$)
        end if

    wait


[button1Click]   'Perform action for the button named 'button1'

    'Insert your own code here

    wait


[button2Click]   'Perform action for the button named 'button2'

    'Insert your own code here

    wait


[button3Click]   'Perform action for the button named 'button3'

    'Insert your own code here

    wait


[button4Click]   'Perform action for the button named 'button4'

    'Insert your own code here

    wait


[button5Click]   'Perform action for the button named 'button5'

    'Insert your own code here

    wait


[button6Click]   'Perform action for the button named 'button6'

    'Insert your own code here

    wait


[button7Click]   'Perform action for the button named 'button7'

    'Insert your own code here

    wait


[button8Click]   'Perform action for the button named 'button8'

    'Insert your own code here

    wait


[button9Click]   'Perform action for the button named 'button9'

    'Insert your own code here

    wait


[button0Click]   'Perform action for the button named 'button0'

    'Insert your own code here

    wait


[open.connect]   'Perform action for menu Game, item Connect, this will connect the client to the server
    if connect = 0 then
    [setup.login.Window]

    '-----Begin code for #login

    WindowWidth = 190
    WindowHeight = 135
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)

    statictext #login.statictext1, "Username:",   5,   5,  66,  20
    statictext #login.statictext2, "Password:",   5,  30,  63,  20
    textbox #login.LoginUserName,  75,   5, 100,  25
    textbox #login.LoginPassword,  75,  30, 100,  25
    checkbox #login.rememberUsername, "Remember username", [rememberUser], [ForgetUser],   5,  55, 156,  25
    button #login.LoginButton,"Login",[LoginButton], UL,   5,  80,  80,  25
    button #login.LoginCancel,"Cancel",[quit.login], UL,  95,  80,  80,  25

    '-----End GUI objects code

    open "Username and password" for dialog_popup as #login
    print #login, "font ms_sans_serif 10"
    print #login, "trapclose [quit.login]"


[login.inputLoop]   'wait here for input event
    wait


[rememberUser]   'Perform action for the textbox named 'LoginUserName'


    'Insert your own code here

    wait



[ForgetUser]   'Perform action for the textbox named 'LoginUserName'

    'Insert your own code here

    wait




[LoginButton]   'Perform action for the button named 'LoginButton'
    print #login.LoginUserName, "!contents? user$";
    print #login.LoginPassword, "!contents? pass$";
    if user$ <> "" and pass$ <> "" then
        goto [quit.login]
    else
        notice "Please type username and password"
        print #login.LoginUserName, ""
        print #login.LoginPassword, ""
        goto [login.inputLoop]
    end if
    wait


[quit.login] 'End the program
        close #login
        if user$ <> "" and pass$ <> "" then
                hd = OpenConnection(user$,pass$)
        end if
        if fail = 1 then
            let func = TCPClose(handle)
            let connect = 0
        end if
    end if
    end if
    wait


[disconnect]   'Perform action for menu Game, item Disconnect
    if connect = 1 then
        let func = TCPClose(handle)
        let connect = 0
    end if
    wait


[open.help]   'Perform action for menu Help, item Help

    'Insert your own code here

    wait


[open.about]   'Perform action for menu Help, item About

    'Insert your own code here

    wait


[open.settings]   'Perform action for menu Settings, item Settings

    'Insert your own code here

    wait

[quit.main] 'End the program
    if connect = 1 then
        let func = TCPClose(handle)
        let connect = 0
    end if
    close #me
    close #main
    end



'---Subs---



'---Funcs---
function SendData(data$)
    let func = TCPSend(handle,test$)
        CallDLL #kernel32, "Sleep", _
        10 As Long, _
        rc As Void
end function

function CheckData(rec$)
    
end function

function OpenConnection(user$,pass$) ' not ready
    let handle = TCPOpen(address$,port)
    let connect = 1
    data1$ = "00000" + VERSION$
    sa = SendData(data1$)
    let rec$ = TCPReceive$(handle)
    if word$(rec$,1) = "00000" and word$(rec$, 4) <> "" then
        SVERSION$ = word$(rec$, 4)
        notice "Wrong version, you have " + VERSION$ + " and the server has " + SVERSION$ + "."
        fail = 1
    end if
    if fail = 0 then
         data1$ = "00002 " + user$ + " " + pass$
         sa = SendData(data1$)
         let rec$ = TCPReceive$(handle)
         if word$(rec$,1) = "00002" and word$(rec$,2) = "ok" then
            notice "Logged in."
         end if
    end if

end function



''''Function TCPOpen()''''''''''
Function TCPOpen(address$,Port)
Timeout=1000
calldll #me, "Open", address$ As ptr,_
Port As Long,_
Timeout As Long, re As Long
TCPOpen=re
End Function

''''Function TCPReceive$()''''''''''
Function TCPReceive$(handle)
buffer=4096
all=0
calldll #me, "ReceiveA" ,handle As Long,_
buffer As Long,_
all As Long, re As long
if re<>0 then TCPReceive$ = winstring(re)
End Function

''''Function TCPSend()''''''''''
Function TCPSend(handle,text1$)
text1$ = text1$ + chr$(7) + chr$(13) + chr$(10)
print text1$
calldll #me, "PrintA", handle As Long,_
text1$ As ptr,re As Long
TCPSend=re
text1$ = ""
End Function

''''Function TCPClose()''''''''''
Function TCPClose(handle)
calldll #me, "CloseA",handle As Long,_
TCPClose As Long
End Function

'*** File check ***
function fileExists(path$, filename$)
  'dimension the array info$( at the beginning of your program
  files path$, filename$, info$()
  fileExists = val(info$(0, 0))  'non zero is true
end function

