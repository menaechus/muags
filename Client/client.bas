'client.bas 20.2.2011
'MUAGS / Markus Tolin

'--- DEFINATIONS ---
open "mesock32.dll" for dll as #me
GLOBAL connect
GLOBAL rec$
GLOBAL handle
GLOBAL text$
GLOBAL PlayerLocX
GLOBAL PlayerLocY
GLOBAL PlayerLocZ
GLOBAL cmd
GLOBAL dummy$
GLOBAL PORT
GLOBAL map$
GLOBAL maplist$
GLOBAL mapDir$
GLOBAL playerData$
GLOBAL VERSION$
GLOBAL address$
GLOBAL fail
GLOBAL versionFail
GLOBAL ServerNews$
GLOBAL LogIn
GLOBAL createOK
GLOBAL charListEnd
GLOBAL inGame
GLOBAL chatArray$
GLOBAL dummymap$


inGame = 0
charListEnd = 0
LogIn = 0
ServerNews$ = "Didn't get the news from the server.."
'--- Directory definations
confdir$ = DefaultDir$ + "\data\"
mapDir$ = confdir$ + "maps\"
mapconf$ = mapDir$ + "maps.list"
'--- End directory def
dim info$(10, 10)
dim dummy$(1000)
dim map$(1000,1000)
dim maplist$(10)'hardcoded max 10
dim playerData$(1000,1000) 'we can trim this when we have some sort of idea on how much data this will hold
dim chatArray$(5) 'for remembering the last 5 lines in the chat window
connect = 0
fail = 0
'--- END OF DEFINATIONS ---

'--- File checks for the important files ---
if fileExists(confdir$, "config.conf") then

 else
    notice "Error!" + chr$(13) + "\data\config.conf is missing, client cannot be started!"
    goto [quit.main2]
  end if

if fileExists(mapDir$, "maps.list") then

  else
    notice "Error!" + chr$(13) + "\data\maps\maps.list is missing, client cannot be started!"
    goto [quit.main2]
  end if

'--- Read the config.conf file ---
ConfigFile$ = confdir$ + "config.conf"
[conf.read]
    open ConfigFile$ for input as #conf
            while not(eof(#conf))
                line input #conf, contents$

                Option$ = word$(contents$, 1, "=")
                Value$  = word$(contents$, 2, "=")

                select case trim$(Option$)
                    Value$ = trim$(Value$)

                    case "Version"
                    VERSION$ = Value$

                    case "ServerAddress"
                    address$ = Value$

                    case "ServerPort"
                    PORT = val(Value$)

                end select
            wend
    close #conf
'read maps list
    open mapconf$ for input as #maps
             while not(eof(#maps))
                line input #maps, contents$

                Option$ = word$(contents$, 1, "=")
                Value$  = word$(contents$, 2, "=")

                select case trim$(Option$)
                    Value$ = trim$(Value$)

                        case "1"
                            maplist$(1) = Value$

                        case "2"
                            maplist$(2) = Value$

                        case "3"
                            maplist$(3) = Value$

                        case "4"
                            maplist$(4) = Value$

                        case "5"
                            maplist$(5) = Value$

                        case "6"
                            maplist$(6) = Value$

                        case "7"
                            maplist$(7) = Value$

                        case "8"
                            maplist$(8) = Value$

                        case "9"
                            maplist$(9) = Value$

                        case "10"
                            maplist$(10) = Value$


            end select
        wend
close #maps

'Main program starts here!
'Client will use one "program" for login, one for char selection and one for the game
'so that the player only sees one window of the above at any given time
'--- 0. Open the connection and check version and get news!
hd = OpenConnection(empty$)
'we need to re open the connection if the server is down during startup of the client

'--- 1. Login/user creating window ---
[setup.login.Window]
    'nomainwin
    WindowWidth = 390
    WindowHeight = 250
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)
	'There is space here for perhaps one image, next to the news
    '-----Begin GUI objects code
    statictext #login.news, ServerNews$,   5,  5,  380,  165
    statictext #login.user, "Username",   5,  175,  63,  20
    TextboxColor$ = "white"
    textbox #login.username,  90,   170, 100,  25
    statictext #login.pass, "Password",   195,  175,  60,  20
    textbox #login.password,  280,  170, 100,  25
    button #login.login,"Login",[login], UL,   5,  195, 185,  25
    button #login.newacc,"Create new account",[newAccount], UL,  195,  195, 185,  25
    '-----End GUI objects code

    open "MUAGS - Login" for window_nf as #login
    print #login, "font ms_sans_serif 10"
    print #login, "trapclose [quit.login]"

[login.inputLoop]   'wait here for input event
    print "versionfail: "; versionFail
    wait

[login]   'Perform action for the button named 'login'
    print #login.username, "!contents? user$";
    print #login.password, "!contents? pass$";
    if user$ <> "" and pass$ <> "" then
        goto [auth.login]
    else
        notice "Please type username and password"
        print #login.username, ""
        print #login.password, ""
        goto [login.inputLoop] 'is this required?
    end if

    wait

[auth.login]
    if user$ <> "" and pass$ <> "" then
          hd = LogIn(user$,pass$)
    end if
    if fail = 1 then
         sa = CloseConn(connect) 'remember to call CloseConn before closing #me, 
								 'this might be a bug, perhaps we should not close the connection on failing the user or passwd?
    end if
    if LogIn = 1 then goto [quit.login.next]
    wait

[newAccount]   'Perform action for the button named 'newacc'
 'popup windows asking for username, password and email
    'then send "00001 username password email" to the server
    WindowWidth = 245
    WindowHeight = 180
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)

    statictext #accountcreation.statictext1, "Username:",   5,  10,  66,  20
    statictext #accountcreation.statictext2, "Password:",   5,  35,  63,  20
    statictext #accountcreation.statictext3, "Retype password:",   5,  60, 109,  20
    statictext #accountcreation.statictext4, "E-mail address:",   5,  85,  94,  20
    TextboxColor$ = "white"
    textbox #accountcreation.usernamecrea, 125,   5, 100,  25
    textbox #accountcreation.passwordcrea, 125,  30, 100,  25
    textbox #accountcreation.passwordreusercrea, 125,  55, 100,  25
    textbox #accountcreation.emailcrea, 125,  80, 100,  25
    button #accountcreation.create,"Create Account",[create.acc], UL,   5,  110, 105,  25
    button #accountcreation.cancel,"Cancel",[create.cancel], UL,   120,  110, 105,  25
    '-----End GUI objects code

    open "Account creation" for window as #accountcreation
    print #accountcreation, "font ms_sans_serif 10"
    print #accountcreation, "trapclose [create.cancel]"

[accountcreation.inputLoop]   'wait here for input event
    wait

[create.acc]
    print #accountcreation.usernamecrea, "!contents? CreateUser$";
    print #accountcreation.passwordcrea, "!contents? CreatePass$";
    print #accountcreation.passwordreusercrea, "!contents? CreatePass2$";
    print #accountcreation.emailcrea, "!contents? CreateEmail$";

    'in here we should tell the player if one of these is empty, so the player knows why the account creation fails
    if CreateUser$ <> "" and CreatePass$ <> "" and CreatePass2$ <> "" and CreateEmail$ <> "" and CreatePass$ = CreatePass2$ then
                        CreateData$ = "00001 " + CreateUser$ + " " + CreatePass$ + " " + CreateEmail$
                        ca = SendData(CreateData$)
                        let rec$ = TCPReceive$(handle)
                        rec = CheckData(rec$)
	else
		notice "Please fill all the required fields"
    end if
	
    if createOK = 1 then
        notice "Account created."
        goto [create.cancel]
    end if
	
    if createOK = 2 then
        notice "Username taken."
        goto [accountcreation.inputLoop]
    end if
    wait

[create.cancel]
    close #accountcreation
    wait

[quit.login] 'End the program
    close #login
    goto [Final.Quit]
    wait

[quit.login.next] 'close the login window and move to character selection screen
    close #login
    goto [Char.start]
    wait

'--- 2. Character selection/creating screen ---
' LogIn = 1 before opening this window!

[Char.start]
    ad = EmptyCharList(dummy$)
    charData$ = "00005"
    ad = SendData(charData$) 'needs to be in it's own function to make reading the char list easier

[Char.start2]
    let rec$ = TCPReceive$(handle)
    rec = CheckData(rec$)
	
    if charListEnd = 0 then
        CallDLL #kernel32, "Sleep", _
            10 As Long, _
            rc As Void

        goto [Char.start2]' wait here until all characters are loaded, GETS STUCK IN A LOOP!!!
				'This will stuck in the loop if the connection is dropped before the charlist is transferred completely.. needs some work :P
    end if

    WindowWidth = 800
    WindowHeight = 350
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)


    '-----Begin GUI objects code

    statictext #character.statictext1, "Account name",   5,  10,  85,  20
    radiobutton #character.select1, playerData$(10,1), [radiobutton2Set], [radiobutton2Reset],   5,  90,  132,  25
    radiobutton #character.select2, playerData$(20,1), [radiobutton3Set], [radiobutton3Reset], 155,  90,  132,  25
    radiobutton #character.select3, playerData$(30,1), [radiobutton4Set], [radiobutton4Reset], 305,  90,  132,  25
    radiobutton #character.select4, playerData$(40,1), [radiobutton5Set], [radiobutton5Reset],   5, 210,  132,  25
    radiobutton #character.select5, playerData$(50,1), [radiobutton6Set], [radiobutton6Reset], 155, 210,  132,  25
    radiobutton #character.select6, playerData$(60,1), [radiobutton7Set], [radiobutton7Reset], 305, 210,  132,  25
    statictext #character.statictext8, "selected character info", 395,  30, 410, 275
    button #character.button10,"Enter the game",[character.enter], UL,   5, 295, 115,  25
    button #character.button11,"New character",[character.new], UL, 125, 295, 110,  25
    button #character.button12,"Delete selected character",[character.delete], UL, 615, 295, 175,  25

    '-----End GUI objects code

    open "Character Selection" for graphics_nf_nsb as #character
    print #character, "down;fill white; flush"
    print #character, "color black; backcolor white"
    print #character, "font ms_sans_serif 10"
    print #character.statictext1, "!font ms_sans_serif 10"
    print #character.statictext8, "!font ms_sans_serif 10"
    print #character.button10, "!font ms_sans_serif 10"
    print #character.button11, "!font ms_sans_serif 10"
    print #character.button12, "!font ms_sans_serif 10"
    print #character, "trapclose [quit.character]"

    print #character.statictext1, user$
    infoText$ = "selected character info: "

	'Grey out the empty char radiobuttons?
	
[character.inputLoop]   'wait here for input event
    wait


[radiobutton2Set]   'Perform action for the radiobutton named 'radiobutton2'
    infoText2$ = infoText$ + chr$(13) + chr$(10) + "name: " + playerData$(10,1) + chr$(13) + chr$(10) + " class: " + playerData$(10,2) + chr$(13) + chr$(10) + " race: " + playerData$(10,3) + chr$(13) + chr$(10) + " gender: " + playerData$(10,4) + chr$(13) + chr$(10) + " level: " + playerData$(10,5)
    print #character.statictext8, infoText2$
    selectedChar$ = playerData$(10, 6)
    cname$ = playerData$(10,1)
    wait

[radiobutton2Reset]   'Perform action for the radiobutton named 'radiobutton2'
   wait



[radiobutton3Set]   'Perform action for the radiobutton named 'radiobutton3'
    infoText2$ = infoText$ + chr$(13) + chr$(10) + "name: " + playerData$(20,1) + chr$(13) + chr$(10) + " class: " + playerData$(20,2) + chr$(13) + chr$(10) + " race: " + playerData$(20,3) + chr$(13) + chr$(10) + " gender: " + playerData$(20,4) + chr$(13) + chr$(10) + " level: " + playerData$(20,5)
    print #character.statictext8, infoText2$
    selectedChar$ = playerData$(20, 6)
    cname$ = playerData$(20,1)
    wait

[radiobutton3Reset]   'Perform action for the radiobutton named 'radiobutton3'
   wait



[radiobutton4Set]   'Perform action for the radiobutton named 'radiobutton4'
    infoText2$ = infoText$ + chr$(13) + chr$(10) + "name: " + playerData$(30,1) + chr$(13) + chr$(10) + " class: " + playerData$(30,2) + chr$(13) + chr$(10) + " race: " + playerData$(30,3) + chr$(13) + chr$(10) + " gender: " + playerData$(30,4) + chr$(13) + chr$(10) + " level: " + playerData$(30,5)
    print #character.statictext8, infoText2$
    selectedChar$ = playerData$(30, 6)
    cname$ = playerData$(30,1)
    wait

[radiobutton4Reset]   'Perform action for the radiobutton named 'radiobutton4'
   wait



[radiobutton5Set]   'Perform action for the radiobutton named 'radiobutton5'
    infoText2$ = infoText$ + chr$(13) + chr$(10) + "name: " + playerData$(40,1) + chr$(13) + chr$(10) + " class: " + playerData$(40,2) + chr$(13) + chr$(10) + " race: " + playerData$(40,3) + chr$(13) + chr$(10) + " gender: " + playerData$(40,4) + chr$(13) + chr$(10) + " level: " + playerData$(40,5)
    print #character.statictext8, infoText2$
    selectedChar$ = playerData$(40, 6)
    cname$ = playerData$(40,1)
    wait

[radiobutton5Reset]   'Perform action for the radiobutton named 'radiobutton5'
   wait



[radiobutton6Set]   'Perform action for the radiobutton named 'radiobutton6'
    infoText2$ = infoText$ + chr$(13) + chr$(10) + "name: " + playerData$(50,1) + chr$(13) + chr$(10) + " class: " + playerData$(50,2) + chr$(13) + chr$(10) + " race: " + playerData$(50,3) + chr$(13) + chr$(10) + " gender: " + playerData$(50,4) + chr$(13) + chr$(10) + " level: " + playerData$(50,5)
    print #character.statictext8, infoText2$
    selectedChar$ = playerData$(50, 6)
    cname$ = playerData$(50,1)
    wait

[radiobutton6Reset]   'Perform action for the radiobutton named 'radiobutton6'
   wait



[radiobutton7Set]   'Perform action for the radiobutton named 'radiobutton7'
    infoText2$ = infoText$ + chr$(13) + chr$(10) + "name: " + playerData$(60,1) + chr$(13) + chr$(10) + " class: " + playerData$(60,2) + chr$(13) + chr$(10) + " race: " + playerData$(60,3) + chr$(13) + chr$(10) + " gender: " + playerData$(60,4) + chr$(13) + chr$(10) + " level: " + playerData$(60,5)
    print #character.statictext8, infoText2$
    selectedChar$ = playerData$(60, 6)
    cname$ = playerData$(60,1)
    wait

[radiobutton7Reset]   'Perform action for the radiobutton named 'radiobutton7'
   wait



[character.enter]   'Perform action for the button named 'button10'
    if selectedChar$ = "" then
        notice "Please select a character, or the character slot you are trying to use is empty"
    else
        goto [character.enter2]
    end if
   wait

[character.enter2]
    ad = GetCharInfo(selectedChar$, cname$)
    'now we are ready to get in to the world!
    goto [PreLoad]
    wait

[character.new]   'Perform action for the button named 'button11'

    'Insert your own code here

    wait


[character.delete]   'Perform action for the button named 'button12'

    'Insert your own code here

    wait

[quit.character] 'End the program
    close #character


'--- 3. Game window ---
[PreLoad]
Print "PRELOAD"
'load the right map and other needed graphics
close #character
currentMap$ = playerData$(100,8)
ad = LoadMap(currentMap$)
Print "MAPS LOADED"
loadbmp "grass", "data\images\world\grass.bmp"
loadbmp "forest", "data\images\world\forest.bmp"
loadbmp "plains", "data\images\world\plains.bmp"
loadbmp "else", "data\images\world\else.bmp"
loadbmp "water", "data\images\world\water.bmp"
loadbmp "player", "data\images\characters\human\default.bmp"
print "GRAPHICS LOADED"
[setup.ingame.Window]

    '-----Begin code for #ingame

    WindowWidth = 800
    WindowHeight = 600
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)

    BackgroundColor$ = "black"
    '-----Begin GUI objects code
PRINT "GUI ELEMENTS STARTING"
    graphicbox #ingame.localMap,   0,   0, 565, 540
    '
    graphicbox #ingame.MapOfArea, 565,   0, 230, 230
    TextboxColor$ = "black"
    textbox #ingame.textinput,   0, 547, 565,  25

print "BUTTONS STARTING"
    bmpbutton #ingame.button1, "data\images\gui\buttonplaceholder.bmp", [bmpbutton1Click], UL, 566, 230
    bmpbutton #ingame.button2, "data\images\gui\buttonplaceholder.bmp", [bmpbutton2Click], UL, 623, 230
    bmpbutton #ingame.button3, "data\images\gui\buttonplaceholder.bmp", [bmpbutton3Click], UL, 680, 230
    bmpbutton #ingame.button4, "data\images\gui\buttonplaceholder.bmp", [bmpbutton4Click], UL, 737, 230
    bmpbutton #ingame.button5, "data\images\gui\buttonplaceholder.bmp", [bmpbutton5Click], UL, 566, 287
    bmpbutton #ingame.button6, "data\images\gui\buttonplaceholder.bmp", [bmpbutton6Click], UL, 623, 287
    bmpbutton #ingame.button7, "data\images\gui\buttonplaceholder.bmp", [bmpbutton7Click], UL, 680, 287
    bmpbutton #ingame.button8, "data\images\gui\buttonplaceholder.bmp", [bmpbutton8Click], UL, 737, 287

    bmpbutton #ingame.inventory, "data\images\gui\inventorybuttonplaceholder.bmp", [inventoryClick], UL, 566, 344
    bmpbutton #ingame.character, "data\images\gui\characterbuttonplaceholder.bmp", [characterClick], UL, 623, 344
    bmpbutton #ingame.friends, "data\images\gui\friendsbuttonplaceholder.bmp", [friendsClick], UL, 680, 344
    bmpbutton #ingame.options, "data\images\gui\optionsbuttonplaceholder.bmp", [optionsClick], UL, 737, 344
    bmpbutton #ingame.logout, "data\images\gui\logoutbuttonplaceholder.bmp", [logoutClick], UL, 566, 401



    '-----End GUI objects code
Print "WINDOW OPENING"
    open "MUAGS - ingame" for window_nf as #ingame
    print #ingame.MapOfArea, "down; fill black; flush"
    print #ingame.localMap, "down; fill black; flush"
    print #ingame.localMap, "when characterInput [keyPress]"
    print #ingame, "font ms_sans_serif 10"
    print #ingame, "trapclose [quit.ingame]"
    inGame = 1
	print #ingame.localMap, "addsprite player player"
    print #ingame.localMap, "spriteround player"
    print #ingame.localMap, "spritevisible player on";
    print #ingame.localMap, "centersprite player"
    
    'playercoords need to be corralative to the gui coords, 1,1 is located at the upped corned.. it should be at the middle of the screen
    pxx = val(playerData$(100,6))
    pyy = val(playerData$(100,7))
	px = pxx + (565/2)
	py = pyy + (460/2)
	ad = DrawPlayer(px,py)
    print #ingame.localMap, "color green"
    print #ingame.localMap, "line 0 460 565 460"
    print #ingame.localMap, "place 10 470"
    print #ingame.localMap, "backcolor white"
    print #ingame.localMap, "|Chat Window."
    print #ingame.localMap, "backcolor black"
    print #ingame.localMap, "flush"


[ingame.inputLoop]   'wait here for input event
    let rec$ = TCPReceive$(handle)
    rec = CheckData(rec$)
    print #ingame.localMap, "setfocus"
    scan
    wait

[keyPress]
    key$ = Inkey$
    if len(key$) < 2 then ' ad = KeyPressCheck(key$) to check the key pressed!
        print "pressed: "; key$
      else
        print "Unhandled special key"
    end if
    goto [ingame.inputLoop]
    wait

[bmpbutton1Click]   'Perform action for the bmpbutton named 'bmpbutton1'

    'Insert your own code here

    wait


[bmpbutton2Click]   'Perform action for the bmpbutton named 'bmpbutton2'

    'Insert your own code here

    wait


[bmpbutton3Click]   'Perform action for the bmpbutton named 'bmpbutton3'

    'Insert your own code here

    wait


[bmpbutton4Click]   'Perform action for the bmpbutton named 'bmpbutton4'

    'Insert your own code here

    wait

[bmpbutton5Click]   'Perform action for the bmpbutton named 'bmpbutton5'

    'Insert your own code here

    wait

[bmpbutton6Click]   'Perform action for the bmpbutton named 'bmpbutton6'

    'Insert your own code here

    wait

[bmpbutton7Click]   'Perform action for the bmpbutton named 'bmpbutton7'

    'Insert your own code here

    wait

[bmpbutton8Click]   'Perform action for the bmpbutton named 'bmpbutton8'

    'Insert your own code here

    wait

[inventoryClick]
[characterClick]
[friendsClick]
[optionsClick]
    wait

[logoutClick]
'logout, quit this window and main window? or just quit? or go to character selection?
'for now it quits everything
    goto [quit.ingame]
    wait

[quit.ingame] 'End the program
    close #ingame
    goto [Final.Quit]
    end


[Final.Quit]
    sa = CloseConn(connect) 'remember to call CloseConn before closing #me
    if connect = 1 then
        let func = TCPClose(handle)
        let connect = 0
    end if
    close #me
    end
'--- Auth code check ---

'*** ingame draw ***
function drawGui(empty)
    print #ingame.localMap, "color green"
    print #ingame.localMap, "line 0 500 565 500"
end function

function DrawPlayer(x,y)
    px = 565 / 2
    py = 460 / 2
    print #ingame.localMap, "spritexy player ";px;" ";py
	print #ingame.localMap, "drawsprites"
	
end function


'*** File check ***
function fileExists(path$, filename$)
  'dimension the array info$( at the beginning of your program
  files path$, filename$, info$()
  fileExists = val(info$(0, 0))  'non zero is true
end function


'---Network Funcs---
function SendData(data$)
    let func = TCPSend(handle,data$)
        CallDLL #kernel32, "Sleep", _
        10 As Long, _
        rc As Void

end function



function CheckData(rec$)
    print "CHECKDATA: " + rec$
    recn$ = word$(rec$, 2)
    select case recn$
        case "00000"
            da = VersionCheck(rec$)
        case "00001"
            da = CreateMsg(rec$)
        case "00002"
            if LogIn = 0 then
                da = LogInCheck(rec$)
            end if
        case "00004"
            da = ReadNews(rec$)
        case "00006"
            print "00006"
            if instr(rec$,"end") then
                charListEnd = 1
            else
                da = GetCharList(rec$)
            end if

        case "00007"
            da = GetCharInfo2(rec$)

        case "00100"
            'locate right place in #ingame.localMap and use array of five? to move the chat up, leaving newest msg at the bottom
            'only show chat if inGame = 1
            'chatArray$(5)

        case "00200"
            da = MoveCheck(rec$)
        'case else
    '        da = AuthErr(rec$)

    end select

end function

function AuthErr(rec$)
    print "Unknown authcode: " + rec$
end function

function LoadMap(currentMap$)
x = val(currentMap$)
mapfile$ = mapDir$ + maplist$(x) + ".map"
print mapfile$
z = 0
open mapfile$ for input as #mapfile
    while not(eof(#mapfile))
                line input #mapfile, dummymap$(z)
                z = z + 1
    wend
    close #mapfile
z = z - 1
        xx = 0
        yy = 0

        for xx = 0 to z
            for yy = 0 to 1000
                map$(yy,xx) = mid$(dummymap$(xx), yy, 1)
            next yy
        next xx
end function

function KeyPressCheck(key$)

end function


function MoveCheck(rec$)

end function

function GetCharInfo(ii$, cname$)
         chardata$ = "00007 " + ii$ + " " + cname$
         print "sent 00007"
         sa = SendData(chardata$)
         let rec$ = TCPReceive$(handle)
         rec = CheckData(rec$)
end function

function GetCharInfo2(rec$)
'read character info into playerData$(100,y)
'100,1 = name
'100,2 = class
'100,3 = race
'100,4 = gender
'100,5 = level
'100,6 = X coord
'100,7 = Y coord
'100,8 = Z coord
'100,9 = MapId
'100,10 = Experience
'rec = "SERVER: 00007 name class race gender level x y z mapid xp
for x = 1 to 9
    z = x + 2
    playerData$(100,x) = word$(rec$, z)
    print "playerData: "; x ; " = " + playerData$(100,x)
next x

end function

function CreateMsg(rec$)
    if instr(rec$,"ok") then
        createOK = 1
    else
        createOK = 2
    end if
end function

function LogIn(user$,pass$)
   if versionFail <> 1 then
         logdata$ = "00002 " + user$ + " " + pass$
         sa = SendData(logdata$)
         let rec$ = TCPReceive$(handle)
         rec = CheckData(rec$)
    end if
end function

function LogInCheck(rec$)
    'these need to be changed to something other that notice
    print "LOGCHECK: " + rec$
    if instr(rec$,"ok") then
          LogIn = 1
          print "Login ok."
    else
          notice "Login failed." ' perhaps some reason for failing?
          LogIn = 0
    end if
end function

function VersionCheck(rec$) ' needs to use allowed versions or something
        SVERSION$ = word$(rec$, 5)
            if SVERSION$ <> VERSION$ then
                notice "Wrong version, you have " + VERSION$ + " and the server has " + SVERSION$ + "."
                versionFail = 1
            end if

end function

function EmptyCharList(dummy$)
for z = 10 to 60 step 10
    playerData$(z, 1) = "empty"
next z
end function

function GetCharList(rec$)
'read character list into playerData$(x,y)
'rec = "SERVER: 00006 ii name class race gender level
'10, x = for character 1 info
'10, 1 = character name
'10, 2 = character class
'10, 3 = character race
'10, 4 = character gender
'10, 5 = character level
'10, 6 = character slot number
'20, x = for character 2 info
print "GETCHARLIST"
print rec$
CharNum = val(word$(rec$, 3))
Print "CHARNUM: " ; CharNum
select case CharNum
    case 1
        z = 10
    case 2
        z = 20
    case 3
        z = 30
    case 4
        z = 40
    case 5
        z = 50
    case 6
        z = 60
    case else
        notice "ERROR"
end select

playerData$(z,6) = ii$

for x = 1 to 5
    wordNum = x + 3
    playerData$(z,x) = word$(rec$, wordNum)
    print "X: " + word$(rec$, wordNum)
next x

print "Z: " + playerData$(z, 1)

end function


function ReadNews(rec$)
    newslen = len(rec$)
    ServerNews1$ = mid$(rec$, 14)
    newslen = len(ServerNews1$) - 3
    ServerNews$ = left$(ServerNews1$, newslen)

end function

function OpenConnection(empty$) 'This needs to check that the connection really opens before defining connect = 1
    let handle = TCPOpen(address$,PORT)
    let connect = 1
    data1$ = "00000 " + VERSION$
    sa = SendData(data1$)
    let rec$ = TCPReceive$(handle)
    rec = CheckData(rec$)
    data1$ = "00004"
    sa = SendData(data1$)
    let rec$ = TCPReceive$(handle)
    rec = CheckData(rec$)
    let rec$ = ""
end function


'--- function to close the connection to the server
function CloseConn(connect)
    if connect = 1 then
      let func = TCPClose(handle)
      let connect = 0
     end if
end function


''''Function TCPOpen()''''''''''
Function TCPOpen(address$,Port)
print "tcpopen: address:port : " + address$ + ":" ; Port
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
print "TCPReceive: " + TCPReceive$
End Function

''''Function TCPSend()''''''''''
Function TCPSend(handle,text1$)
text2$ = text1$ + chr$(7) + chr$(13) + chr$(10)
print "TCPSend: " + text2$
calldll #me, "PrintA", handle As Long,_
text1$ As ptr,re As Long
TCPSend=re
text2$ = ""
End Function

''''Function TCPClose()''''''''''
Function TCPClose(handle)
calldll #me, "CloseA",handle As Long,_
TCPClose As Long
End Function
