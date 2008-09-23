'Form created with the help of Freeform 3 v03-27-03
'Generated on Feb 24, 2008 at 20:08:20
dim info$(10, 10)

conff$ =  "starter.conf"
if fileExists(DefaultDir$, "starter.conf") then
    goto [conf.read]
  else
    notice "Error!" + chr$(13) + "starter.conf is missing, server cannot be started!"
    goto [quit.main2]
  end if

[conf.read]

    open conff$ for input as #conf
        line input #conf, version$
        line input #conf, address$
        line input #conf, port$
    close #conf
    VERSION = val(version$)
    port = val(port$)
    'noticeline$ = "MAX: " + maxplayers$ + " PORT: " + port$ + "."
    'notice noticeline$



[setup.starter.Window]

    '-----Begin code for #starter
    'port = 1568 'we could read this from a config file?
    'address$ = "127.0.0.1" 'we should read this from a config too
    'nomainwin
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
    print #starter.account, "!contents? account$"
    print #starter.pwd, "!contents? pwd$"
    print #starter.pwdagain, "!contents? pwda$"
    if pwd$ = pwda$ then
        ok = 1
    else
        ok = 0
        errori = 1
    end if
    text$ = "00001 " + account$ + " " + pwd$
    print text$
    if ok = 0 goto [error]
        let handle = TCPOpen(address$,port)
        let rec$ = TCPReceive$(handle)
        print rec$
        if word$(rec$, 1) = "00100" then
            CallDLL #kernel32, "Sleep", _
            10 As Long, _
            rc As Void
            let func = TCPSend(handle,text$)
        end if
        let rec$ = TCPReceive$(handle)
        print rec$
        if word$(rec$, 2) = "00001" then
            if word$(rec$, 3) = "ok" then
                acc = 1
            end if
        end if
    let func = TCPClose(handle)
    if acc = 1 then notice "Account created!"
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
[quit.main2]
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

'*** File check ***
function fileExists(path$, filename$)

  'dimension the array info$( at the beginning of your program

  files path$, filename$, info$()

  fileExists = val(info$(0, 0))  'non zero is true

end function
