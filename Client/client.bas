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
GLOBAL versionFail
GLOBAL ServerNews$
GLOBAL LogIn
ServerNews$ = "Didn't get the news from the server.."
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
'--- 0. Open the connection and check version and get news!
hd = OpenConnection(empty$)

'--- 1. Login/user creating window ---
[setup.login.Window]
    'nomainwin
    WindowWidth = 390
    WindowHeight = 250
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)

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
          hd = OpenConnection(empty$)
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
    print #accountcreation, "trapclose [create.cancel]"

[accountcreation.inputLoop]   'wait here for input event
    wait

[create.acc]
    print #accountcreation.usernamecrea, "!contents? CreateUser$";
    print #accountcreation.passwordcrea, "!contents? CreatePass$";
    print #accountcreation.passwordreusercrea, "!contents? CreatePass2$";
    print #accountcreation.emailcrea, "!contents? CreateEmail$";

    if CreateUser$ <> "" then
        if CreatePass$ <> "" then
            if CreatePass2$ <> "" then
                if CreateEmail$ <> "" then
                    if CreatePass$ = CreatePass2$ then
                        CreateData$ = "00001 " + CreateUser$ + " " + CreatePass$ + " " + CreateEmail$
                        ca = SendData(CreateData$)
                    else

                    end if
                end if
             end if
         end if
    end if

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
' LogIn = 1 before opening this window!

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
    print "Data sent: " + data$
    let func = TCPSend(handle,data$)
        CallDLL #kernel32, "Sleep", _
        30 As Long, _
        rc As Void
end function

function CheckData(rec$)
    print "CheckData rec: " + rec$
    recn$ = word$(rec$, 2)
    select case recn$
        case "00000"
            da = VersionCheck(rec$)
        case "00002"
            if LogIn = 0 then
                da = LogInCheck(rec$)
            end if
        case "00004"
            da = ReadNews(rec$)
    end select
end function

function LogIn(user$,pass$)
    if versionFail <> 1 then
         data1$ = "00002 " + user$ + " " + pass$
         sa = SendData(data1$)
         let rec$ = TCPReceive$(handle)
         if word$(rec$,1) = "00002" and word$(rec$,2) = "ok" then
            notice "Logged in."
         end if
    end if
end function

function LogInCheck(rec$)
    if word$(rec$,2) = "ok" then
          notice "Logged in."
          LogIn = 1
    else
          notice "Login failed."
          LogIn = 0
    end if
end function

function VersionCheck(rec$)
        SVERSION$ = word$(rec$, 5)
            if SVERSION$ <> VERSION$ then
                notice "Wrong version, you have " + VERSION$ + " and the server has " + SVERSION$ + "."
                versionFail = 1
            end if
            print "VersionFail: " ; versionFail
end function

function ReadNews(rec$)
    newslen = len(rec$)
    ServerNews1$ = mid$(rec$, 14)
    newslen = len(ServerNews1$) - 3
    ServerNews$ = left$(ServerNews1$, newslen)
    print "ServNews: "; ServerNews$
end function

function OpenConnection(empty$) ' not ready
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
