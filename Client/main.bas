'Form created with the help of Freeform 3 v03-27-03
'Generated on Feb 25, 2008 at 17:16:59
    port = 1568 'we could read this from a config file?
    address$ = "127.0.0.1" 'we should read this from a config too
    open "mesock32.dll" for dll as #me
    global handle
    logged = 0
[setup.main.Window]

    '-----Begin code for #main

    'nomainwin
    WindowWidth = 1027
    WindowHeight = 760
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)


    '-----Begin GUI objects code

    TexteditorColor$ = "white"
    texteditor #main.gameview,   0,   2, 1020, 680
    TextboxColor$ = "white"
    textbox #main.textbox1,   0, 687, 900,  25
    button #main.send,"Send",[send], UL, 905, 687, 105,  25


    '-----End GUI objects code

    '-----Begin menu code

    menu #main, "File",_
                "Login" , [Login],_
                "Logout", [Logout],_
                "Quit"  , [quit.main]

    menu #main, "Help",_
                "About", [help.about]

    menu #main, "Edit"  ' <-- Texteditor menu.


    '-----End menu code

    open "MUAGS Client" for window_nf as #main
    print #main, "font ms_sans_serif 10"
    print #main, "trapclose [quit.main]"


[main.inputLoop]   'wait here for input event
   ' if logged = 0 then
    '    #main.send "!Disable"
    'end if
    wait



[send]   'Perform action for the button named 'send'
    outgoing$ = ""
    print #main.textbox1, "!contents? outgoing$"
    print #main.textbox1, ""
    text$ = "00100 " + outgoing$
    let func = TCPSend(handle,text$)
    goto [GameLoop]
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
    if word$(rec$, 2) = "00002" then
            if word$(rec$, 3) = "ok" then
                notice "Logged in"
                logged = 1
            end if
        end if
    close #Login
    login = 0
    let connect = 1
    goto [GameLoop]
    wait


[Logout]   'Perform action for menu File, item Logout
    let func = TCPClose(handle) 'this will be removed later on
    let connect = 0
    #main.gameview "Logged Out"
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
    scan
    'CallDLL #kernel32, "Sleep", _
    '    10 As Long, _
    '    rc As Void

    'if logged = 1 then
    '    #main.send "!Enable"
    'end if
    if connect = 1 then
        let rec$ = ""
        let rec$ = TCPReceive$(handle)
        print rec$
        if rec$ <> "" then print #main.gameview, rec$
    end if
   ' goto [GameLoop]
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
