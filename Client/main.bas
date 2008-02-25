'Form created with the help of Freeform 3 v03-27-03
'Generated on Feb 25, 2008 at 17:16:59
    port = 1568 'we could read this from a config file?
    address$ = "127.0.0.1" 'we should read this from a config too
    open "mesock32.dll" for dll as #me


[setup.main.Window]

    '-----Begin code for #main

    nomainwin
    WindowWidth = 1027
    WindowHeight = 768
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)


    '-----Begin GUI objects code

    TexteditorColor$ = "white"
    texteditor #main.gameview,   0,   2, 905, 650
    TextboxColor$ = "white"
    textbox #main.textbox1,   0, 687, 900,  25
    button #main.send,"Send",[send], UL, 905, 687, 105,  25
    button #main.button1,"1",[button1Click], UL,   0, 657,  25,  25
    button #main.button2,"2",[button2Click], UL,  30, 657,  25,  25
    button #main.button3,"3",[button3Click], UL,  60, 657,  25,  25
    button #main.button4,"4",[button4Click], UL,  90, 657,  25,  25
    button #main.button5,"5",[button5Click], UL, 120, 657,  25,  25
    button #main.button6,"6",[button6Click], UL, 150, 657,  25,  25
    button #main.button7,"7",[button7Click], UL, 180, 657,  25,  25
    button #main.button8,"8",[button8Click], UL, 210, 657,  25,  25
    button #main.button9,"9",[button9Click], UL, 240, 657,  25,  25
    button #main.button0,"0",[button0Click], UL, 270, 657,  25,  25
    bmpbutton #main.bmpbuttonup, "data\images\arrowup.bmp", [bmpbuttonUPClick], UL, 945, 582
    bmpbutton #main.bmpbuttonleft, "data\images\arrowleft.bmp", [bmpbuttonLEFTClick], UL, 920, 607
    bmpbutton #main.bmpbuttonright, "data\images\arrowright.bmp", [bmpbuttonRIGHTClick], UL, 970, 607
    bmpbutton #main.bmpbuttondown, "data\images\arrowdown.bmp", [bmpbuttonDOWNClick], UL, 945, 632

    '-----End GUI objects code

    '-----Begin menu code

    menu #main, "File",_
                "Login" , [Login],_
                "Logout", [Logout],_
                "Quit"  , [Quit]

    menu #main, "Help",_
                "About", [help.about]

    menu #main, "Edit"  ' <-- Texteditor menu.


    '-----End menu code

    open "MUAGS Client" for window_nf as #main
    print #main, "font ms_sans_serif 10"
    print #main, "trapclose [quit.main]"


[main.inputLoop]   'wait here for input event
    wait



[send]   'Perform action for the button named 'send'

    'Insert your own code here

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


[bmpbuttonUPClick]   'Perform action for the bmpbutton named 'bmpbuttonup'

    'Insert your own code here

    wait


[bmpbuttonLEFTClick]   'Perform action for the bmpbutton named 'bmpbuttonleft'

    'Insert your own code here

    wait


[bmpbuttonRIGHTClick]   'Perform action for the bmpbutton named 'bmpbuttonright'

    'Insert your own code here

    wait


[bmpbuttonDOWNClick]   'Perform action for the bmpbutton named 'bmpbuttondown'

    'Insert your own code here

    wait


[Login]   'Perform action for menu File, item Login
    login = 1
    WindowWidth = 200
    WindowHeight = 130
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)


    '-----Begin GUI objects code

    statictext #Login.statictext1, "Account",  10,  22,  48,  20
    statictext #Login.statictext2, "Password",   5,  47,  60,  20
    TextboxColor$ = "white"
    textbox #Login.account,  85,  17, 100,  25
    textbox #Login.passwd,  85,  42, 100,  25
    button #Login.button5,"Login",[Login2], UL,   5,  67, 180,  25

    '-----End GUI objects code

    open "Login" for window as #Login
    print #Login, "font ms_sans_serif 10"

    wait

[Login2]
    let handle = TCPOpen(address$,port)
    let rec$ = TCPReceive$(handle)
    print #Login.account, "!contents? account$"
    print #Login.passwd, "!contents? pwd$"

    logincode$ = "00002 "; account$; " "; pwd$

    if word$(rec$, 1) = "SERVER:" then
            CallDLL #kernel32, "Sleep", _
            10 As Long, _
            rc As Void
            text$ = "00002 " + account$ + " " + pwd$
            let func = TCPSend(handle,text$)
    end if
    let rec$ = TCPReceive$(handle)
    if connect = 1 then
        func = TCPClose(handle)
        let connect = 0
    end if
    if word$(rec$, 2) = "00002" then
            if word$(rec$, 3) = "ok" then
                notice "Logged in"
            end if
        end if
    let func = TCPClose(handle)
    close #Login
    wait


[Logout]   'Perform action for menu File, item Logout

    'Insert your own code here

    wait


[Quit]   'Perform action for menu File, item Quit

    'Insert your own code here

    wait


[help.about]   'Perform action for menu Help, item About

    'Insert your own code here

    wait

[quit.main] 'End the program
    if connect = 1 then
        func = TCPClose(handle)
        let connect = 0
    end if

    if login = 1 then
        close #Login
    end if
    close #me
    close #main
    end

[GameLoop]

wait


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

''''Function TCPPrint()''''''''''
Function TCPSend(handle,text$)
calldll #me, "PrintA", handle As Long,_
text$ As ptr,re As Long
TCPPrint=re
End Function

''''Function TCPClose()''''''''''
Function TCPClose(handle)
calldll #me, "CloseA",handle As Long,_
TCPClose As Long
End Function
