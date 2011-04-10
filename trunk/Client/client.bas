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
GLOBAL VERSION$
GLOBAL address$
GLOBAL fail
configDir$ = DefaultDir$ + "\data\"
mapDir$ = configDir$ + "maps\"
dim info$(10, 10)
dim dummy$(1000)
dim map$(1000,10) 
	'map$(x,0) = MapName from maplist$
	'map$(x,1) = 
dim maplist$(1000)
dim playerData$(1000,1000)
connect = 0
fail = 0
'--- END OF DEFINATIONS ---

'--- File checks for the important files ---
if fileExists(configDir$, "config.conf") then
    'goto [conf.read]
  else
    notice "Error!" + chr$(13) + "\data\config.conf is missing, client cannot be started!"
    goto [quit.main2]
  end if
  
if fileExists(mapDir$, "maps.list") then
    'goto [map.read]
  else
    notice "Error!" + chr$(13) + "\data\maps\maps.list is missing, client cannot be started!"
    goto [quit.main2]
  end if
  
'--- Read the config.conf file ---
ConfigFile$ = configDir$ + "config.conf"
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
    close #ConfigFile  
  
'Main program starts here!
'Client will use one "program" for login, one for char selection and one for the game
'so that the player only sees one window of the above at any given time  

'--- 1. Login/user creating window ---
[setup.login.Window]
    '-----Begin code for #login
    nomainwin
    WindowWidth = 210
    WindowHeight = 150
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)

    '-----Begin GUI objects code
    statictext #login.user, "Username",   5,  10,  63,  20
    TextboxColor$ = "white"
    textbox #login.username,  90,   5, 100,  25
    statictext #login.pass, "Password",   5,  35,  60,  20
    textbox #login.password,  90,  30, 100,  25
    button #login.login,"Login",[login], UL,   5,  55, 185,  25
    button #login.newacc,"Create new account",[newAccount], UL,  5,  85, 185,  25
    '-----End GUI objects code

    open "MUAGS - Login" for window as #login
    print #login, "font ms_sans_serif 10"
    print #login, "trapclose [quit.login]"

[login.inputLoop]   'wait here for input event
    wait

[login]   'Perform action for the button named 'login'
    'Insert your own code here
    wait

[newAccount]   'Perform action for the button named 'newacc'
    'Insert your own code here
    wait

[quit.login] 'End the program
    close #login
	end
	
'--- 2. Character selection/creating screen ---

'--- 3. Game window ---




