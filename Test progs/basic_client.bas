'Generated on Feb 25, 2008 at 17:16:59
    port = 1568 'we could read this from a config file?
    address$ = "127.0.0.1" 'we should read this from a config too
    open "mesock32.dll" for dll as #me
    global handle
    logged = 0
    let handle = TCPOpen(address$,port)
    let rec$ = TCPReceive$(handle)
    print rec$
'    if word$(rec$, 1) = "00100" then
'            let rec$ = ""
'            CallDLL #kernel32, "Sleep", _
'            10 As Long, _
'            rc As Void
'            text$ = "00002 mena test"
'            let func = TCPSend(handle,text$)
'    end if
    let connect = 1


[start]


[main]
input test$
if test$ = "quit" then 
    goto [quit]
else 
    let func = TCPSend(handle,test$)
            CallDLL #kernel32, "Sleep", _
            10 As Long, _
            rc As Void
end if
wait

[quit]
if connect = 1 then
        let func = TCPClose(handle)
        let connect = 0
end if
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

''''Function TCPPrint()'''''''''
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

