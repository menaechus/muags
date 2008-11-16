'Form created with the help of Freeform 3 v03-27-03
'Generated on Feb 25, 2008 at 17:16:59
    port = 1568 'we could read this from a config file?
    address$ = "127.0.0.1" 'we should read this from a config too
    open "mesock32.dll" for dll as #me
    global handle
    logged = 0
    mapfilee$ = DefaultDir$ + "\data\maps\"
    mapfile$ = mapfilee$ + "map.1"

    global PlayerLocX
    global PlayerLocY
    global cmd
    dim dummy$(1000)
    dim map1$(1000,1000)
    PlayerLocX = 2
    PlayerLocY = 2
    x = 0
    open mapfile$ for input as #1
[loop]

    input #1, dummy$(x)
    x = x + 1
    if eof(#1) = 0 then [loop]
close #1
x = x - 1
y = 0

[dummyTOmap]

xx = 0
yy = 0

    for xx = 0 to x
        for yy = 0 to 1000
        map1$(yy,xx) = mid$(dummy$(xx), yy, 1)
        'if map1$(xx,yy) = "" then yy = 1000
        next yy
    next xx

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



'---Subs---
sub CheckCmd command$
    cmd = 0
    if command$ = "n" then cmd = 1
    if command$ = "e" then cmd = 2
    if command$ = "w" then cmd = 3
    if command$ = "s" then cmd = 4

end sub


'---Funcs---
function MovePlayer(cmd)
OldX = PlayerLocX
OldY = PlayerLocY
if cmd = 1 then PlayerLocY = PlayerLocY - 1
if cmd = 2 then PlayerLocX = PlayerLocX + 1
if cmd = 3 then PlayerLocX = PlayerLocX - 1
if cmd = 4 then PlayerLocY = PlayerLocY + 1
if PlayerLocX < 0 then PlayerLocX = 0
if PlayerLocY < 0 then PlayerLocY = 0
if map1$(PlayerLocX, PlayerLocY) = "#" then
    PlayerLocX = OldX
    PlayerLocY = OldY
end if

'and in here we should inform the server of the new coordinates of the player

end function

function drawMap(PlayerLocX, PlayerLocY)

    one$ = ""
    two$ = ""
    three$ = ""
    four$ = ""
    six$ = ""
    seven$ = ""
    eight$ = ""
    nine$ = ""
    ten$ = ""
    eleven$ = ""
    twelve$ = ""
    thirteen$ = ""
    fourteen$ = ""
    fifteen$ = ""
    sixteen$ = ""
    seventeen$ = ""
    eighteen$ = ""
    nineteen$ = ""
    twenty$ = ""
    twentyone$ = ""
    twentytwo$ = ""
    twentythree$ = ""
    twentyfour$ = ""
    twentyfive$ = ""



    oneX = PlayerLocX - 1
    oneY = PlayerLocY - 1
    if oneX < 0 then oneX = 1
    if oneY < 0 then oneY = 0
    one$ = map1$(oneX, oneY)

    twoX = PlayerLocX
    twoY = PlayerLocY - 1
    if twoX < 0 then twoX = 1
    if twoY < 0 then twoY = 0
    two$ = map1$(twoX, twoY)

    threeX = PlayerLocX + 1
    threeY = PlayerLocY - 1
    if threeX < 0 then threeX = 1
    if threeY < 0 then threeY = 0
    three$ = map1$(threeX, threeY)

    fourX = PlayerLocX - 1
    fourY = PlayerLocY
    if fourX < 0 then fourX = 1
    if fourY < 0 then fourY = 0
    four$ = map1$(fourX, fourY)

    sixX = PlayerLocX + 1
    sixY = PlayerLocY
    if sixX < 0 then sixX = 1
    if sixY < 0 then sixY = 0
    six$ = map1$(sixX, sixY)

    sevenX = PlayerLocX - 1
    sevenY = PlayerLocY + 1
    if sevenX < 0 then sevenX = 1
    if sevenY < 0 then sevenY = 0
    seven$ = map1$(sevenX, sevenY)

    eightX = PlayerLocX
    eightY = PlayerLocY + 1
    if eightX < 0 then eightX = 1
    if eightY < 0 then eightY = 0
    eight$ = map1$(eightX, eightY)

    nineX = PlayerLocX + 1
    nineY = PlayerLocY + 1
    if nineX < 0 then nineX = 1
    if nineY < 0 then nineY = 0
    nine$ = map1$(nineX, nineY)

    tenX = PlayerLocX - 2
    tenY = PlayerLocY - 2
    if tenX < 0 then tenX = 0
    if tenY < 0 then tenY = 0
    ten$ = map1$(tenX, tenY)

    elevenX = PlayerLocX - 1
    elevenY = PlayerLocY - 2
    if elevenX < 0 then elevenX = 0
    if elevenY < 0 then elevenY = 0
    eleven$ = map1$(elevenX, elevenY)

    twelveX = PlayerLocX
    twelveY = PlayerLocY - 2
    if twelveY < 0 then twelveY = 0
    twelve$ = map1$(twelveX, twelveY)

    thirteenX = PlayerLocX + 1
    thirteenY = PlayerLocY - 2
    if thirteenX < 0 then thirteenX = 0
    if thirteenY < 0 then thirteenY = 0
    thirteen$ = map1$(thirteenX, thirteenY)

    fourteenX = PlayerLocX + 2
    fourteenY = PlayerLocY - 2
    if fourteenX < 0 then fourteenX = 0
    if fourteenY < 0 then fourteenY = 0
    fourteen$ = map1$(fourteenX, fourteenY)

    fifteenX = PlayerLocX - 2
    fifteenY = PlayerLocY - 1
    if fifteenX < 0 then fifteenX = 0
    if fifteenY < 0 then fifteenY = 0
    fifteen$ = map1$(fifteenX, fifteenY)

    sixteenX = PlayerLocX + 2
    sixteenY = PlayerLocY - 1
    if sixteenX < 0 then sixteenX = 0
    if sixteenY < 0 then sixteenY = 0
    sixteen$ = map1$(sixteenX, sixteenY)

    seventeenX = PlayerLocX - 2
    seventeenY = PlayerLocY
    if seventeenX < 0 then seventeenX = 0
    seventeen$ = map1$(seventeenX, seventeenY)

    eighteenX = PlayerLocX + 2
    eighteenY = PlayerLocY
    if eighteenX < 0 then eighteenX = 0
    eighteen$ = map1$(eighteenX, eighteenY)

    nineteenX = PlayerLocX - 2
    nineteenY = PlayerLocY + 1
    if nineteenX < 0 then nineteenX = 0
    if nineteenY < 0 then nineteenY = 0
    nineteen$ = map1$(nineteenX, nineteenY)

    twentyX = PlayerLocX + 2
    twentyY = PlayerLocY + 1
    if twentyX < 0 then twentyX = 0
    if twentyY < 0 then twentyY = 0
    twenty$ = map1$(twentyX, twentyY)

    twentyoneX = PlayerLocX - 2
    twentyoneY = PlayerLocY + 2
    if twentyoneX < 0 then twentyoneX = 0
    if twentyoneY < 0 then twentyoneY = 0
    twentyone$ = map1$(twentyoneX, twentyoneY)

    twentytwoX = PlayerLocX - 1
    twentytwoY = PlayerLocY + 2
    if twentytwoX < 0 then twentytwoX = 0
    if twentytwoY < 0 then twentytwoY = 0
    twentytwo$ = map1$(twentytwoX, twentytwoY)

    twentythreeX = PlayerLocX
    twentythreeY = PlayerLocY + 2
    if twentythreeY < 0 then twentythreeY = 0
    twentythree$ = map1$(twentythreeX, twentythreeY)

    twentyfourX = PlayerLocX + 1
    twentyfourY = PlayerLocY + 2
    if twentyfourX < 0 then twentyfourX = 0
    if twentyfourY < 0 then twentyfourY = 0
    twentyfour$ = map1$(twentyfourX, twentyfourY)

    twentyfiveX = PlayerLocX + 2
    twentyfiveY = PlayerLocY + 2
    if twentyfiveX < 0 then twentyfiveX = 0
    if twentyfiveY < 0 then twentyfiveY = 0
    twentyfive$ = map1$(twentyfiveX, twentyfiveY)


'    if one$ = "" then one$ = "#"
'    if two$ = "" then two$ = "#"
'    if three$ = "" then three$ = "#"
'    if four$ = "" then four$ = "#"
'    if six$ = "" then six$ = "#"
'    if seven$ = "" then seven$ = "#"
'    if eight$ = "" then eight$ = "#"
'    if nine$ = "" then nine$ = "#"

'these should not be print's :D
    print
    print ten$ + eleven$ + twelve$ + thirteen$ + fourteen$
    print fifteen$ + one$ + two$ + three$ + sixteen$
    print seventeen$ + four$ + "@" + six$ + eighteen$
    print nineteen$ + seven$ + eight$ + nine$ + twenty$
    print twentyone$ + twentytwo$ + twentythree$ + twentyfour$ + twentyfive$
    print

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

