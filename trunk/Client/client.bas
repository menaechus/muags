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
'--- Directory definations
confdir$ = DefaultDir$ + "\data\"
mapDir$ = confdir$ + "maps\"
'--- End directory def
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
if fileExists(confdir$, "config.conf") then
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

'Main program starts here!
'Client will use one "program" for login, one for char selection and one for the game
'so that the player only sees one window of the above at any given time

'--- 1. Login/user creating window ---
[setup.login.Window]
    'nomainwin
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
    print #login.username, "!contents? user$";
    print #login.password, "!contents? pass$";
    if user$ <> "" and pass$ <> "" then
        goto [auth.login]
    else
        notice "Please type username and password"
        print #login.username, ""
        print #login.password, ""
        goto [login.inputLoop]
    end if

    wait

[auth.login]
    if user$ <> "" and pass$ <> "" then
          hd = OpenConnection(user$,pass$)
    end if
    if fail = 1 then
          let func = TCPClose(handle)
          let connect = 0
    end if

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
    print #accountcreation, "trapclose [quit.accountcreation]"

[accountcreation.inputLoop]   'wait here for input event
    wait
[create.cancel]
    close #accountcreation
    wait

[quit.login] 'End the program
    close #login
    sa = CloseConn(connect) 'remember to call CloseConn before closing #me
    close #me
    end

'--- 2. Character selection/creating screen ---

'--- 3. Game window ---

'--- Auth code check ---

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

end function

function OpenConnection(user$,pass$) ' not ready
    let handle = TCPOpen(address$,port)
    let connect = 1
    data1$ = "00000 " + VERSION$
        print "output: " + data1$ + " !!! "
    sa = SendData(data1$)
    let rec$ = TCPReceive$(handle)
    print "input: "; rec$
    if rec$ = "" then
      notice "No connection to the server."
      print "no connection"
      fail = 2
    end if
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


'--- function to close the connection to the server
function CloseConn(connect)
    if connect = 1 then
      let func = TCPClose(handle)
      let connect = 0
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
