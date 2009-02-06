[start]

    nomainwin
    WindowWidth = 1024
    WindowHeight = 768
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)
    button #logIn.exit,"Exit",[exitClick], UL,  21, 690, 101,  25
    button #logIn.logIn,"Log in",[logInClick], UL, 408, 375, 203,  25
    textbox #logIn.accountName, 408, 320, 203,  25
    textbox #logIn.password, 408, 345, 203,  25
    textbox #logIn.news, 715, 103, 203, 202
    statictext #logIn.News, "News", 714,  54, 201,  25
    open "Log In" for window as #logIn
    print #logIn.accountName, "Account name"
    print #logIn.password, "Password"
    print #logIn.news, "Account name is TestAccount," + chr$(13) + chr$(10) + "Password is TestPassword"
    wait

[exitClick]

    confirm "Exit?"; answer$
    if answer$ <> "yes" then wait
    close #logIn
    end

[logInClick]

    print #logIn.accountName, "!contents?"
    input #logIn.accountName, accountName$
    print #logIn.password, "!contents?"
    input #logIn.password, password$
    if accountName$ = "TestAccount" goto [accountOk]
    statictext #accountNotOk.field, "Incorrect account", 10, 15, 170, 20
    button #accountNotOk.ok, "OK", [accountNotOkokClicked], UL, 70, 40, 50, 30
    WindowWidth = 200
    WindowHeight = 110
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)
    Open "Incorrect account" for window as #accountNotOk
    wait

[accountNotOkokClicked]

    close #accountNotOk
    wait

[accountOk]

    if password$ = "TestPassword" goto [passwordOk]
    statictext #passwordNotOk.field, "Incorrect Password", 10, 15, 170, 20
    button #passwordNotOk.ok, "OK", [passwordNotOkokClicked], UL, 70, 40, 50, 30
    WindowWidth = 200
    WindowHeight = 110
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)
    Open "Incorrect Password" for window as #passwordNotOk
    wait

[passwordNotOkokClicked]

    close #passwordNotOk
    wait

