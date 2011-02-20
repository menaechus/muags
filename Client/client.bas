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
GLOBAL map1$
GLOBAL maplist$
GLOBAL VERSION$
GLOBAL address$
GLOBAL fail
configDir$ = DefaultDir$ + "\data\"
mapDir$ = configDir$ + "maps\"
dim info$(10, 10)
dim dummy$(1000)
dim map1$(1000,1000)
dim maplist$(1000)
dim playerData$(1000,1000)
connect = 0
fail = 0
'--- END OF DEFINATIONS ---

'file checks for the important files
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
  
'Read the config.conf file
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