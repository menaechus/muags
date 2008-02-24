'Form created with the help of Freeform 3 v03-27-03
'Generated on Feb 24, 2008 at 20:08:20


[setup.starter.Window]

    '-----Begin code for #starter
    PORT = 1568 'we could read this from a config file?
    address$ = "127.0.0.1" 'we should read this from a config too
    nomainwin
    WindowWidth = 350
    WindowHeight = 270
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)
    open "mesock32.dll" for dll as #me

    '-----Begin GUI objects code

    groupbox #starter.groupbox9, "Create an Account",   5, 112, 330, 125
    groupbox #starter.groupbox8, "Start the game",   5,   7, 330, 100
    button #starter.button10,"Start the Game",[Start], UL,  15,  42, 310,  25
    statictext #starter.statictext11, "Account",  15, 132, 105,  20
    statictext #starter.statictext12, "Password",  15, 157,  60,  20
    statictext #starter.statictext14, "Password Again",  15, 182,  98,  20
    TextboxColor$ = "white"
    textbox #starter.account, 185, 127, 135,  25
    textbox #starter.pwd, 185, 152, 135,  25
    textbox #starter.pwdagain, 185, 177, 135,  25
    button #starter.button18,"Create the Account",[accountcreate], UL,  15, 207, 305,  25

    '-----End GUI objects code

    open "MUAGS Starter" for window_nf as #starter
    print #starter, "font ms_sans_serif 10"
    print #starter, "trapclose [quit.starter]"


[starter.inputLoop]   'wait here for input event
    wait



[Start]   'This will just start the game

    'Insert your own code here

    wait


[accountcreate]   'this should check the passwords first, and then send them to the server software
                  'that will do some checks and then generate the accound,
                  'returning OK or Error
    if connect = 1 then
        func = TCPClose(handle)
        let connect = 0
    end if
    print #starter.account, "!contest? account$"
    print #starter.pwd, "!contents? pwd$"
    print #starter.pwdagain, "!contents? pwda$"
    if pwd$ = pwda$ then
        ok = 1
    else
        ok = 0
        errori = 1
    end if
    if ok = 0 goto [error]
    let handle = TCPOpen(address$,port)
    let connect = 1
    if connect = 1 then
        text$ = "00001 " + account$ + " " + pwd$
        let func = TCPSend(handle,text$)
    end if
    let func = TCPClose(handle)
    
    
    wait


[error]
    if errori = 1 then
        notice "Error, the passwords don't match!"
    end if
    goto [starter.inputLoop]
    wait

[quit.starter] 'End the program
    if connect = 1 then let func = TCPClose(handle)
    close #starter
    close #me
    end



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

