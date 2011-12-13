'server.bas 19.2.2011
'MUAGS / Markus Tolin

GLOBAL vc

GLOBAL XPrate
GLOBAL HPregen
GLOBAL MPregen
GLOBAL EPregen

GLOBAL VERSION$ 
GLOBAL MAXPLAYERS
GLOBAL PORT

GLOBAL confdir$
GLOBAL extconfdir$
GLOBAL mapdir$

GLOBAL accountc$
GLOBAL passwordc$
GLOBAL PLAYER$ 
GLOBAL Player
GLOBAL logok
GLOBAL admin 'we will remove this later on

GLOBAL ServerNews$
GLOBAL NewsFile$

GLOBAL createFail
GLOBAL maplist$
GLOBAL map$
GLOBAL dummy$

dim dummy$(1000,1000)
dim info$(10, 10)
dim maplist$(1000)
dim map$(1000,10)

'directory definations
confdir$ = DefaultDir$ + "\data\"
extconfdir$ = confdir$ + "\configs\"
mapdir$ = confdir$ + "\maps\"
racedir$ = confdir$ + "\races\"

'configuration and needed files definations
levelconf$ = extconfdir$ + "level.exp"
conff$ = confdir$ + "config.conf"
mapconf$ = mapdir$ + "maps.list"
NewsFile$ = confdir$ + "news.file"

'file checks for the important files
'can we change this in to a function?
if fileExists(extconfdir$, "level.exp") then

  else
    notice "Error!" + chr$(13) + "\data\config\level.exp is missing, server cannot be started!"
    goto [quit.main2]
  end if
  
if fileExists(mapdir$, "maps.list") then

  else
    notice "Error!" + chr$(13) + "\data\maps\maps.list is missing, server cannot be started!"
    goto [quit.main2]
  end if

if fileExists(confdir$, "news.file") then
    s = ReadNewsFile(NewsFile$)
   else
    ServerNews$ = "News file missing!"
end if

if fileExists(confdir$, "config.conf") then
    goto [conf.read]
  else
    notice "Error!" + chr$(13) + "\data\config.conf is missing, server cannot be started!"
    goto [quit.main2]
  end if
  
if fileExists(racedir$, "races.list") then
    goto [conf.read]
  else
    notice "Error!" + chr$(13) + "\data\races\races.list is missing, server cannot be started!"
    goto [quit.main2]
  end if  
  
  
  
'Read the config.conf file
[conf.read]
    open conff$ for input as #conf
            while not(eof(#conf))
                line input #conf, contents$

                Option$ = word$(contents$, 1, "=")
                Value$  = word$(contents$, 2, "=")

                select case trim$(Option$)
                    Value$ = trim$(Value$)

                    case "Version"
                    VERSION$ = Value$

                    case "Maxplayers"
                    MAXPLAYERS = val(Value$)

                    case "Port"
                    PORT = val(Value$)

                    case "ExpRate"
                    XPrate = val(Value$)

                    case "HPregen"
                    HPregen = val(Value$)

                    case "MPregen"
                    MPregen = val(Value$)

                    case "EPregen"
                    EPregen = val(Value$)

                end select
            wend
    close #conf


'These need to be set AFTER the config file reading
admin = MAXPLAYERS + 1 'DO NOT CHANGE THIS, OR THE SERVER WINDOW COMMANDS WILL NOT WORK.
Dim player.sock(MAXPLAYERS)    ' Socket descriptor
Dim player.inbuf$(MAXPLAYERS)  ' Input buffer
Dim player.outbuf$(MAXPLAYERS) ' Output buffer
Dim player.match(MAXPLAYERS)   ' The number to match
Dim PLAYER$(MAXPLAYERS, 1000) 'need to read from config.conf!!!
    ' Initialize client data.
    For plr = 1 To MAXPLAYERS
        PLAYER$(plr, 2) = "0" 'empty version ok
        PLAYER$(plr, 3) = "0" 'empty login ok
        player.sock(plr) = -1 ' Invalidate sockets.
    Next

[setup.main.Window]
    '-----Begin code for #main
    Open "wsock32" For DLL As #wsock32
    Open "WMLiberty" For DLL As #wmlib
    'nomainwin
    WindowWidth = 550
    WindowHeight = 410
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)
    '-----Begin GUI objects code
    TexteditorColor$ = "white"
    texteditor #main.log,   5,  67, 530, 285
    button #main.button1,"Start",[Start], UL,   5,   5, 530,  25
    button #main.button2,"Stop",[Stop], UL,   5,  37, 530,  25
    '-----End GUI objects code

    '-----Begin menu code
    menu #main, "Edit"  ' <-- Texteditor menu.
    '-----End menu code

    open "MUAGS Server" for window as #main
    print #main, "font ms_sans_serif 10"
    print #main, "trapclose [quit.main]"


[main.inputLoop]   'wait here for input event
    wait

[Start]
    ' Now create a socket, bind it to a local port, set some
    ' network events to trap, and start listening for clients.

    Call WinsockInit

    Err = 1 ' Assume failure
    If WSAStartup(MAKEWORD(2, 2)) = 0 Then

        #main.log "> Winsock initialized."

        sockaddr.sinfamily.struct = 2 'AF_INET
        sockaddr.sinzero.struct = String$(8, 0)
        sockaddr.sinport.struct = htons(PORT)
        If sockaddr.sinport.struct <> -1 Then
            sockaddr.sinaddr.struct = htonl(0) 'INADDR_ANY=0
            If sockaddr.sinaddr.struct <> -1 Then
                sock = socket(2, 1, 0) 'AF_INET=2:SOCK_STREAM=1
                If sock <> -1 Then
                    #main.log "> Socket created."

                    If bind(sock) = 0 Then
                        #main.log "> Port bind successful."

                        'FD_READ=1:FD_WRITE=2:FD_OOB=4:FD_ACCEPT=8:FD_CONNECT=16:FD_CLOSE=32
                        If WSAAsyncSelect(sock, HWnd(#main), _WM_USER, 1 Or 2 Or 8 Or 32) <> -1 Then
                            #main.log "> Events selected."

                            If listen(sock, 1) = 0 Then
                                #main.log "> Listening for incoming connections."

                                Err = 0 ' Success!

                                Callback lpfnCB, SockProc( Long, Long, Long, Long ), Long
                                rc = SetWMHandler(HWnd(#main), _WM_USER, lpfnCB, 1)
                            End If
                        End If
                    End If
                End If
            End If
        End If
    End If

    If Err Then
        #main.log "> ERROR: "; GetWSAErrorString$(WSAGetLastError())
        If sock <> -1 Then
            rc = closesocket(sock)
        End If
    Else
        myip = GetLocalIP()
        #main.log "> Clients connect to ["; InetNtoA$(myip); ":"; PORT; "]"
        #main.log "> or ["; GetHostByAddr$(myip); ":"; PORT; "]"
    End If

    Player = 1

[s_Loop] ' Main loop where the server checks the data coming from clients
    Scan
	'we might need to change this to make sure that the server will keep up with many players
    CallDLL #kernel32, "Sleep", _
        10 As Long, _
        rc As Void

    If player.sock(Player) <> -1 Then
        buf$ = player.inbuf$(Player)
        If Len(buf$) > 2 Then
            print "Buffer= " ; buf$
            I = InStr(buf$, Chr$(13))
            If I = 0 Then I = InStr(buf$, Chr$(10))
                If I <> 0 Then
                    'print "s_loop, Player: "; player.sock(Player)  ;", MSG: "  ;buf$
                    ad = CheckCommand(Player, buf$)
                end if
            player.inbuf$(Player) = Mid$(player.inbuf$(Player), I + 1)
        end if
    End If

    Player = Player + 1
    If Player > MAXPLAYERS Then Player = 1
    GoTo [s_Loop]

    wait


[Stop]  'stopping the server

' Clean up sockets.
    For plr = 1 To MAXPLAYERS
        If player.sock(plr) <> -1 Then rc = closesocket(player.sock(plr))
    Next
    rc = closesocket(sock)
    Call WSACleanup
    #main.log "Socket closed"


    wait

[quit.main] 'End the program
' Clean up sockets.
    For plr = 1 To MAXPLAYERS
        If player.sock(plr) <> -1 Then rc = closesocket(player.sock(plr))
    Next
    rc = closesocket(sock)
    Call WSACleanup

    Close #wmlib
    Close #wsock32
    close #main
    end

[quit.main2] 'for premature stopping of the server
    end

'*** SUBS/Funcs for the engine ***
function ReadNewsFile(NewsFile$)
    open NewsFile$ for input as #news
        line input #news, ServerNews$
    close #news
    if ServerNews$ = "" then ServerNews$ = "News file empty."
end function



function CheckCommand(Player, buf$) ' check the command the client sent for the server
' NEED TO CHANGE THIS TO call other functions more.. it's not necessary to do all the command from here
caseword$ = word$(buf$, 1)
select case caseword$
  case "00000"
    if PLAYER$(Player, 2) = "0" then
      vc = 0
      CVersion$ = word$(buf$, 2)
      ad = VersionCheck(CVersion$, VERSION$)
            if vc = 0 then
                output$ = "00000 Wrong version " + VERSION$
                print output$
                plr = 101
                a = pbroadcast(Player, plr, output$)
                PLAYER$(Player, 2) = "0"
            else
                output$ = "00000 Version ok "  + VERSION$
                print output$
                plr = 101
                a = pbroadcast(Player, plr, output$)
                PLAYER$(Player, 2) = "1"
            end if
    end if

  case "00001"
    accountc$ = word$(buf$, 2)
    passwordc$ = word$(buf$, 3)
    emailc$ = word$(buf$, 4)
    ad = CreateAccount(accountc$,passwordc$,emailc$)
    if createFail = 0 then
        output$ = "00001 ok"
    else
        output$ = "00001 username"
    end if
    plr = 101
    a = pbroadcast(Player, plr, output$)

  case "00002"
    if PLAYER$(Player, 3) = "0" then ' login auth
      logok = 0
      account$ = word$(buf$, 2)
      passwd$ = word$(buf$, 3)
      ad = Loginauth(account$,passwd$, Player)
                if logok = 1 then
                    PLAYER$(Player, 3) = "1"
                    output$ = "00002 ok"
                    Logfail = 0
                    plr = 101
                    a = pbroadcast(Player, plr, output$)

                else
                    PLAYER$(Player, 3) = "0"
                    output$ = "00002 failed"
                    Logfail = 1
                    plr = 101
                    a = pbroadcast(Player, plr, output$)
                end if
    end if

  case "00004"
    output$ = "00004 " + ServerNews$
    plr = 101
    a = pbroadcast(Player, plr, output$)

  case "00005"
    ad = GetCharacterList(dummy1$)

  case "00100"
    if PLAYER$(Player, 3) = "1" then
                output$ = buf$
                a = broadcast(Player,output$)
     end if

  case else
    output$ = "99999 unknown authcode" 'for debugging reasons
    plr = 101
    a = pbroadcast(Player, plr, output$)


  end select
[EndCheckCommand]

end function


function MoveCheck(Player, dir) ' this will hold the movement checks

end function

function GetCharacterList(dummy1$) 'get all the char names and info from /data/account_name/1/ - /6/
'open *.char in each folder if it exists and read info from there, then send that info to the client
'PLAYER$(Player, 100) to (Player, 200) is reserved for this info
'FOR and WHILE cancel each other here, need to work on this
Acc$ = DefaultDir$ + "/data/accounts/" + PLAYER$(Player, 0)
print "GCL: " + Acc$
for ii = 1 to 6
    chardir$ = Acc$ + "/" ; ii ; "/"
    if fileExists(chardir$, "*.char") then
        charfile$ = chardir$ + info$(1,0)
        charr = GetCharacterList2(charfile$,ii)
		else
		sendString$ = "00006 " + "end" + " "
		print sendString$
		sendChar = pbroadcast(Player, plr, sendString$)
    end if
next ii
end function

function GetCharacterList2(charfile$,ii) 'file reading for GetCharacterList()
'This should not go to the player$(array)? perhaps an array just for the while it takes to
'send this info to the client?
        if ii = 1 then arraynum = 100
        if ii = 2 then arraynum = 110
        if ii = 3 then arraynum = 120
        if ii = 4 then arraynum = 130
        if ii = 5 then arraynum = 140
        if ii = 6 then arraynum = 150
        open charfile$ for input as #char
            while not(eof(#char))
                line input #char, contents$
                Option$ = word$(contents$, 1, "=")
                Value$  = word$(contents$, 2, "=")

                select case trim$(Option$)
                    Value$ = trim$(Value$)
                    print "GCL: " + Option$ + " : " + Value$
                    case "Name"
                        arraynum2 = arraynum + 1
                        PLAYER$(Player, arraynum2) = Value$

                    case "Class"
                        arraynum2 = arraynum + 3
                        PLAYER$(Player, arraynum2) = Value$

                    case "Race"
                        arraynum2 = arraynum + 4
                        PLAYER$(Player, arraynum2) = Value$

                    case "Gender"
                        arraynum2 = arraynum + 5
                        PLAYER$(Player, arraynum2) = Value$

                    case "Level"
                        arraynum2 = arraynum + 2
                        PLAYER$(Player, arraynum2) = Value$

                end select
                arraynum3 = arraynum + 6
                PLAYER$(Player, arraynum3) = charfile$ 
            wend
        close #char
        namee = arraynum + 1
		level = arraynum + 2
        class = arraynum + 3
        race = arraynum + 4
        gender = arraynum + 5
        
        'send to client: 00006 ii name class race gender level
        sendString$ = "00006 " ; ii ; " " + PLAYER$(Player, namee) + " " + PLAYER$(Player, class) + " " + PLAYER$(Player, race) + " " + PLAYER$(Player, gender) + " " + PLAYER$(Player, level) + " "
        print PLAYER$(Player, 0) + " " + sendString$
        plr = 101
        sendChar = pbroadcast(Player, plr, sendString$)
end function

function CreateAccount(Account$,Passwd$,Email$) ' used for the acc creation
' need to do the code for sql system here
'needs to check if the username is allready taken!
    userlvl = 1
    #main.log "Create Acc: " + Account$ + " : " + Passwd$
    Acc$ = DefaultDir$ + "/data/accounts/" + Account$
    char1$ = Acc$ + "/1/"
    char2$ = Acc$ + "/2/"
    char3$ = Acc$ + "/3/"
    char4$ = Acc$ + "/4/"
    char5$ = Acc$ + "/5/"
    char6$ = Acc$ + "/6/"
    Pass$ = DefaultDir$ + "/data/accounts/" + Account$ + "/" + Account$ + ".o"
    ctime$ = date$() + " : " + time$()
    result = mkdir(Acc$)
    if result <> 0 then createFail = 1
    open Pass$ for output as #acccreate
        print #acccreate, Passwd$
        print #acccreate, ctime$
        print #acccreate, Email$
        print #acccreate, userlvl
    close #acccreate
    r = mkdir(char1$)
    r = mkdir(char2$)
    r = mkdir(char3$)
    r = mkdir(char4$)
    r = mkdir(char5$)
    r = mkdir(char6$)
end function

function Loginauth(Account$,Passwd$,Player)' login auth
    #main.log "LOG Auth: " + Account$ + " : " + Passwd$
    print "LOG Auth: " + Account$ + " : " + Passwd$
    Acc$ = DefaultDir$ + "/data/accounts/" + Account$
    Acc1$ = Account$ + ".o"
    Pass$ = DefaultDir$ + "/data/accounts/" + Account$ + "/" + Account$ + ".o"
    if fileExists(Acc$, Acc1$) then
        open Pass$ for input as #conf
            line input #conf, password$
            line input #conf, date$
            line input #conf, email$
            line input #conf, acclevel$
        close #conf
        if Passwd$ = password$ then
            PLAYER$(Player, 1) = acclevel$
            PLAYER$(Player, 0) = Account$
            logok = 1
        else
            logok = 0
        end if
    else
        ErrorLog = 0002
    end if

end function

function VersionCheck(ClientVersion$, ServerVersion$) ' version check, perhaps chacge to allowed versions? not any server update requires client upgrade
    if ClientVersion$ = ServerVersion$ then
        vc = 1
    else
        vc = 0
    end if
end function

'*** Application Procedures ***
function broadcast(from,buf$) ' this will become the channel system some day
    trimbuf$ = mid$(buf$, 7)
    trimbuf2$ = trimbuf$
    from$ = PLAYER$(from, 0)
    buf$ = "00100 ";from$;" : ";trimbuf2$ 
    for i = 1 to MAXPLAYERS
        If player.sock(i) <> -1 Then
            obuf$ = player.outbuf$(i) + buf$ + chr$(7) + chr$(13) + chr$(10)
            player.outbuf$(i) = Send$(player.sock(i), obuf$, Len(obuf$), 0)
        end if
    next i
end function

function whisper(user, from$, buf$) 'whisper system
    buf$ = "01000 " ; from$ ; " " ; buf
    player.outbuf$(user) = Send$(player.sock(user), buf$, Len(buf$), 0)
end function

function pbroadcast(user, from, buf$)' this will be used for client-server messaging
' needs a lot of changes!
    If from = admin then
        buf$ = "SERVER: " + buf$  'If message is from Server, Add SERVER:.
    else
        buf$ = "User";from;": PRIVATE: " + buf$  'If not, add which user it's from. this should go into whisper function
    End If
    obuf$ = player.outbuf$(user) + buf$ + chr$(7) + chr$(13) + chr$(10)
    player.outbuf$(user) = Send$(player.sock(user), obuf$, Len(obuf$), 0)
    #main.log "Sent to Client ";user
End Function

function emptyMem(plr)
for x = 0 to 1000 
	PLAYER$(plr, x) = ""
next x
end function

Function SockProc( hWnd, uMsg, sock, lParam )
' Callback function to handle a Windows message
' forwarded by WMLiberty. Called when a relevant
' network event occurs.

    Select Case LOWORD(lParam)
        Case 1 'FD_READ
            b$ = Recv$(sock, 256, 0)
            While Len(b$)
                buf$ = buf$ + b$
                b$ = Recv$(sock, 256, 0)
            Wend
            plr = GetPlayer(sock)
            player.inbuf$(plr) = player.inbuf$(plr) + buf$
        Case 2 'FD_WRITE
            plr = GetPlayer(sock)
            buf$ = player.outbuf$(plr)
            player.outbuf$(plr) = Send$(sock, buf$, 256, 0)
            If player.match(plr) = 0 And Len(player.outbuf$(plr)) = 0 Then
                rc = closesocket(sock)
                player.inbuf$(plr) = ""
                player.sock(plr) = -1
            End If
        Case 8 'FD_ACCEPT
            plr = GetPlayer(-1)
            If plr Then
                s = accept(sock)
                '#main.log "User "; plr; " ["; _
                '      GetHostByAddr$(sockaddr.sinaddr.struct); "] joined!"

                player.sock(plr) = s
                player.match(plr) = Int(100 * Rnd(0)) + 1
                'a = broadcast(admin, "-- User ";plr;" joined! -- ")
            Else
                ' Too many players. Close connection.
                rc = closesocket(sock)
            End If
        Case 32 'FD_CLOSE
            ' Flush the buffers.
            rc = SockProc(hWnd, uMsg, sock, 1) 'force read

            ' Clean up.
            plr = GetPlayer(sock)
            player.sock(plr) = -1
            player.inbuf$(plr) = ""
            player.outbuf$(plr) = ""
            player.match(plr) = 0

            #main.log "> User "; plr; " disconnected." 'in here we need to make sure that any info about the player is removed from mem! 
			'ad = emptyMem(plr)
            'a = broadcast(admin, "-- User ";plr;" disconnected. -- ")
        Case 64
            rc = SockProc(hWnd, uMsg, sock, 1) 'force read

            ' Clean up.
            plr = GetPlayer(sock)
            player.sock(plr) = -1
            player.inbuf$(plr) = ""
            player.outbuf$(plr) = ""
            player.match(plr) = 0

            #main.log "> User "; plr; " kicked."
            a = broadcast(admin, "-- User ";plr;" kicked. -- ")
    End Select
End Function

Sub WinsockInit
' Initializes structs used in Winsock calls.
    Struct hostent, _
        hname As Long, _
        haliases As Long, _
        haddrtype As Word, _
        hlength As Word, _
        haddrlist As Long

    Struct sockaddr, _
        sinfamily As Short, _
        sinport As UShort, _
        sinaddr As ULong, _
        sinzero As Char[8]

    Struct WSAData, _
        wVersion As Word, _
        wHighVersion As Word, _
        szDescription As Char[257], _
        szSystemStatus As Char[129], _
        iMaxSockets As Word, _
        iMaxUdpDg As Word, _
        lpVendorInfo As Long
End Sub

Function GetPlayer( sock )
    For plr = MAXPLAYERS To 1 Step -1
        If player.sock(plr) = sock Then Exit For
    Next
    GetPlayer = plr
End Function

Function GetLocalIP()
    sName$ = GetHostName$()
    CallDLL #wsock32, "gethostbyname", _
        sName$ As Ptr, _
        phe As ULong
    If phe Then
        helen = Len(hostent.struct)
        CallDLL #kernel32, "RtlMoveMemory", _
            hostent As Struct, _
            phe As ULong, _
            helen As Long, _
            rc As Void
        plong = hostent.haddrlist.struct
        Struct p, addrlist As ULong
        CallDLL #kernel32, "RtlMoveMemory", _
            p As Struct, _
            plong As ULong, _
            4 As Long, _
            rc As Void
        plong = p.addrlist.struct
        Struct p, addr As ULong
        hlength = hostent.hlength.struct
        CallDLL #kernel32, "RtlMoveMemory", _
            p As Struct, _
            plong As ULong, _
            hlength As Long, _
            rc As Void
        GetLocalIP = p.addr.struct
    End If
End Function

Function woBang$( raw$ )
' Kludge to print a string that could start with an
' exclamation point, or bang (!). Am I missing something?
    woBang$ = raw$
    bangs = 0
    While Mid$(raw$, bangs+1, 1) = "!"
        bangs = bangs + 1
    Wend
    If bangs Then
        bang$ = Left$(raw$, bangs)
        woBang$ = Mid$(raw$, bangs+1)

        #main.log "!Lines ln"
        #main.log "!Line "; ln; " ln$"
        #main.log "!Select "; Len(ln$)+1; " "; ln
        #main.log "!Insert bang$"
        #main.log "!Select 1 1"
    End If
End Function

'*** General Procedures ***

Function CrLf$()
    CrLf$ = Chr$(13)+Chr$(10)
End Function

Function LOWORD( dw )
    LOWORD = (dw And 65535)
End Function

Function MAKEWORD( b1, b2 )
    MAKEWORD = b1 Or (256 * b2)
End Function

Function String$( num, ch )
    If num > 0 Then
        String$ = Chr$(ch)
        While Len(String$) < num
            String$ = String$ + String$
        Wend
        String$ = Left$(String$, num)
    End If
End Function

'*** Winsock Wrappers ***

Function GetHostByAddr$( addr )
    Struct p, addr As ULong
    p.addr.struct = addr
    CallDLL #wsock32, "gethostbyaddr", _
        p As Struct, _
        4 As Long, _
        2 As Long, _ 'AF_INET=2
        phe As Long
    If phe Then
        helen = Len(hostent.struct)
        CallDLL #kernel32, "RtlMoveMemory", _
            hostent As Struct, _
            phe As ULong, _
            helen As Long, _
            rc As Void
        GetHostByAddr$ = WinString(hostent.hname.struct)
    Else
        GetHostByAddr$ = "localhost"
    End If
End Function

Function GetHostByName$( sName$ )
    CallDLL #wsock32, "gethostbyname", _
        sName$ As Ptr, _
        phe As ULong
    If phe Then
        helen = Len(hostent.struct)
        CallDLL #kernel32, "RtlMoveMemory", _
            hostent As Struct, _
            phe As ULong, _
            helen As Long, _
            rc As Void
        GetHostByName$ = WinString(hostent.hname.struct)
    End If
End Function

Function GetHostName$()
    buf$ = Space$(256)+Chr$(0)
    CallDLL #wsock32, "gethostname", _
        buf$ As Ptr, _
        256 As Long, _
        rc As Long
    GetHostName$ = Trim$(buf$)
End Function

Function GetWSAErrorString$( errnum )
    Select Case errnum
        Case 10004: e$ = "Interrupted system call."
        Case 10009: e$ = "Bad file number."
        Case 10013: e$ = "Permission Denied."
        Case 10014: e$ = "Bad Address."
        Case 10022: e$ = "Invalid Argument."
        Case 10024: e$ = "Too many open files."
        Case 10035: e$ = "Operation would block."
        Case 10036: e$ = "Operation now in progress."
        Case 10037: e$ = "Operation already in progress."
        Case 10038: e$ = "Socket operation on nonsocket."
        Case 10039: e$ = "Destination address required."
        Case 10040: e$ = "Message too long."
        Case 10041: e$ = "Protocol wrong type for socket."
        Case 10042: e$ = "Protocol not available."
        Case 10043: e$ = "Protocol not supported."
        Case 10044: e$ = "Socket type not supported."
        Case 10045: e$ = "Operation not supported on socket."
        Case 10046: e$ = "Protocol family not supported."
        Case 10047: e$ = "Address family not supported by protocol family."
        Case 10048: e$ = "Address already in use."
        Case 10049: e$ = "Can't assign requested address."
        Case 10050: e$ = "Network is down."
        Case 10051: e$ = "Network is unreachable."
        Case 10052: e$ = "Network dropped connection."
        Case 10053: e$ = "Software caused connection abort."
        Case 10054: e$ = "Connection reset by peer."
        Case 10055: e$ = "No buffer space available."
        Case 10056: e$ = "Socket is already connected."
        Case 10057: e$ = "Socket is not connected."
        Case 10058: e$ = "Can't send after socket shutdown."
        Case 10059: e$ = "Too many references: can't splice."
        Case 10060: e$ = "Connection timed out."
        Case 10061: e$ = "Connection refused."
        Case 10062: e$ = "Too many levels of symbolic links."
        Case 10063: e$ = "File name too long."
        Case 10064: e$ = "Host is down."
        Case 10065: e$ = "No route to host."
        Case 10066: e$ = "Directory not empty."
        Case 10067: e$ = "Too many processes."
        Case 10068: e$ = "Too many users."
        Case 10069: e$ = "Disk quota exceeded."
        Case 10070: e$ = "Stale NFS file handle."
        Case 10071: e$ = "Too many levels of remote in path."
        Case 10091: e$ = "Network subsystem is unusable."
        Case 10092: e$ = "Winsock DLL cannot support this application."
        Case 10093: e$ = "Winsock not initialized."
        Case 10101: e$ = "Disconnect."
        Case 11001: e$ = "Host not found."
        Case 11002: e$ = "Nonauthoritative host not found."
        Case 11003: e$ = "Nonrecoverable error."
        Case 11004: e$ = "Valid name, no data record of requested type."
        Case Else:  e$ = "Unknown error "; errno; "."
    End Select
    GetWSAErrorString$ = e$
End Function

Function InetNtoA$( inaddr )
    CallDLL #wsock32, "inet_ntoa", _
        inaddr As ULong, _
        pstr As ULong
    InetNtoA$ = WinString(pstr)
End Function

Function Recv$( s, buflen, flags )
    Recv$ = Space$(buflen)+Chr$(0)
    CallDLL #wsock32, "recv", _
        s As Long, _
        Recv$ As Ptr, _
        buflen As Long, _
        flags As Long, _
        buflen As Long
    Recv$ = Left$(Recv$, buflen)
    'print "RECEIVE: " + Recv$
End Function

Function Send$( s, buf$, buflen, flags )
    buflen = Min(Len(buf$), buflen)
    CallDLL #wsock32, "send", _
        s As Long, _
        buf$ As Ptr, _
        buflen As Long, _
        flags As Long, _
        buflen As Long
    If buflen > 0 Then Send$ = Mid$(buf$, buflen+1)
End Function

'*** Winsock Thin Wrappers ***

Function accept( s )
    Struct p, length As Long
    p.length.struct = Len(sockaddr.struct)
    CallDLL #wsock32, "accept", _
        s As Long, _
        sockaddr As Struct, _
        p As Struct, _
        accept As Long
End Function

Function bind( s )
    namelen = Len(sockaddr.struct)
    CallDLL #wsock32, "bind", _
        s As Long, _
        sockaddr As Struct, _
        namelen As Long, _
        bind As Long
End Function

Function closesocket( s )
    CallDLL #wsock32, "closesocket", _
        s As Long, _
        closesocket As Long
End Function

Function htonl( hostlong )
    CallDLL #wsock32, "htonl", _
        hostlong As ULong, _
        htonl As ULong
End Function

Function htons( hostshort )
    CallDLL #wsock32, "htons", _
        hostshort As Word, _
        htons As Word
End Function

Function inetaddr( cp$ )
    CallDLL #wsock32, "inet_addr", _
        cp$ As Ptr, _
        inetaddr As ULong
End Function

Function listen( s, backlog )
    CallDLL #wsock32, "listen", _
        s As Long, _
        backlog As Long, _
        listen As Long
End Function


Function socket( af, type, protocol )
    CallDLL #wsock32, "socket", _
        af As Long, _
        type As Long, _
        protocol As Long, _
        socket As Long
End Function

Function WSAAsyncSelect( s, hWnd, wMsg, lEvent )
    CallDLL #wsock32, "WSAAsyncSelect", _
        s As Long, _
        hWnd As ULong, _
        wMsg As ULong, _
        lEvent As Long, _
        WSAAsyncSelect As Long
End Function

Sub WSACleanup
    CallDLL #wsock32, "WSACleanup", _
        r As Void
End Sub

Function WSAGetLastError()
    CallDLL #wsock32, "WSAGetLastError", _
        WSAGetLastError As Long
End Function

Function WSAStartup( wVersionRequested )
    CallDLL #wsock32, "WSAStartup", _
        wVersionRequested As Word, _
        WSAData As Struct, _
        WSAStartup As Long
End Function

'*** WMLiberty Thin Wrappers ***

Function SetWMHandler( hWnd, uMsg, lpfnCB, lSuccess )
    CallDLL #wmlib, "SetWMHandler", _
        hWnd As Long, _
        uMsg As Long, _
        lpfnCB As Long, _
        lSuccess As Long, _
        SetWMHandler As Long
End Function

'*** File check ***
function fileExists(path$, filename$)
  'dimension the array info$( at the beginning of your program
  files path$, filename$, info$()
  fileExists = val(info$(0, 0))  'non zero is true
end function
