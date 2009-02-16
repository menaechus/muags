[start]

    nomainwin
    WindowWidth = 1024
    WindowHeight = 768
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)
    graphicbox #logIn.backGround, 0, 0, 1024, 768
    button #logIn.exit,"Exit",[exitLogClick], UL,  21, 690, 101,  25
    button #logIn.logIn,"Log in",[logInClick], UL, 408, 375, 203,  25
    textbox #logIn.accountName, 408, 320, 203,  25
    textbox #logIn.password, 408, 345, 203,  25
    textbox #logIn.news, 715, 103, 203, 202
    statictext #logIn.News, "News", 714,  54, 201,  25
    open "Log In" for window_nf as #logIn
    print #logIn.backGround, "getbmp logInBG 0 0 1024 768"
    print #logIn.backGround, "background logInBG";
    print #logIn.backGround, "drawsprites";
    print #logIn.accountName, "Account"
    print #logIn.password, "Password"
    print #logIn.news, "Account is TestAccount," + chr$(13) + chr$(10) + "Password is TestPassword"
    wait

[exitLogClick]

    confirm "Exit?"; answer$
    if answer$ <> "yes" then wait
    close #logIn
    end

[exitLoggedClick]

    confirm "Exit?"; answer$
    if answer$ <> "yes" then wait
    close #loggedIn
    end

[logInClick]

    print #logIn.accountName, "!contents?"
    input #logIn.accountName, accountName$
    print #logIn.password, "!contents?"
    input #logIn.password, password$
    if accountName$ = "TestAccount" goto [accountOk]
    if accountName$ = "testAccount" goto [accountOk]
    if accountName$ = "Testaccount" goto [accountOk]
    if accountName$ = "testaccount" goto [accountOk]
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
    if password$ = "testPassword" goto [passwordOk]
    if password$ = "Testpassword" goto [passwordOk]
    if password$ = "testpassword" goto [passwordOk]
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

[passwordOk]

    close #logIn
    goto [loggedIn]

[loggedIn]

    nomainwin
    WindowWidth = 1024
    WindowHeight = 768
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)
    graphicbox #loggedIn.backGround, 0, 0, 1024, 768
    graphicbox #loggedIn.characterPic, 408, 102, 203, 409
    button #loggedIn.logOut,"Log out",[logOutClick], UL,  122, 690, 101,  25
    button #loggedIn.logOut,"Exit",[exitLoggedClick], UL,  21, 690, 101,  25
    button #loggedIn.play,"Play",[playClick], UL, 408, 575, 203,  25
    button #loggedIn.create,"Create character",[creator], UL, 408, 620, 203,  25
    textbox #loggedIn.news, 715, 103, 203, 202
    TextboxColor$ = "white"
    textbox #loggedIn.charName, 408, 520, 203,  25
    textbox #loggedIn.charGender, 408, 545, 101,  25
    textbox #loggedIn.charRace, 510, 545, 101,  25
    statictext #loggedIn.character, "Character", 409,  54, 201,  25
    statictext #loggedIn.News, "News", 714,  54, 201,  25
    statictext #loggedIn.clientInfo, "Account info", 104,  53, 201,  25
    textbox #loggedIn.info1, 103, 102, 202,  25
    'textbox #loggedIn.info2, 103, 124, 202,  25
    'textbox #loggedIn.info3, 103, 146, 202,  25
    'textbox #loggedIn.info4, 103, 168, 202,  25
    open "Logged In" for window as #loggedIn

[createdstart]

    print #loggedIn.backGround, "getbmp logInBG 0 0 1024 768"
    print #loggedIn.backGround, "background logInBG";
    print #loggedIn.backGround, "drawsprites";
    print #loggedIn.charName, name$
    print #loggedIn.charGender, gender$
    print #loggedIn.charRace, race$
    print #loggedIn.characterPic, "down; fill white; flush"
    print #loggedIn, "font ms_sans_serif 10"
    print #loggedIn.info1, accountName$
    ''print #loggedIn.info2,
    'print #loggedIn.info3,
    'print #loggedIn.info4,
    wait

[logOutClick]

  confirm "Log out?"; answer$
  if answer$ <> "yes" then wait
  close #loggedIn
  goto [start]

[playClick]

    if character$ = "ok" goto [GameMap]
    goto [noCharCreated]

[noCharCreated]

    statictext #noCharCreated.field, "Create a character to play", 10, 15, 170, 20
    button #noCharCreated.ok, "OK", [noCharCreatedokClicked], UL, 70, 40, 50, 30
    WindowWidth = 200
    WindowHeight = 110
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)
    Open "Create a character" for window as #noCharCreated
    wait

[noCharCreatedokClicked]

    close #noCharCreated
    wait

[GameMap]


    statictext #GameMap.field, "Jos peli ois valmis", 10, 15, 170, 20
    button #GameMap.ok, "Lopeta", [GameMapLopetaClicked], UL, 70, 40, 50, 30
    WindowWidth = 200
    WindowHeight = 110
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)
    Open "Nyt vois pelaa" for window as #GameMap
    wait

[GameMapLopetaClicked]

    close #GameMap
    goto [logOutClick]

[creator]

    textbox #creator.race, 25, 25, 400, 20
    button #creator.human, "Human", [humanClicked], UL, 25, 50, 100, 30
    button #creator.unavailable, "Unavailable", [unavailableClicked], UL, 125, 50, 100, 30
    button #creator.unavailable, "Unavailable", [unavailableClicked], UL, 225, 50, 100, 30
    button #creator.unavailable, "Unavailable", [unavailableClicked], UL, 325, 50, 100, 30
    textbox #creator.gender, 25, 125, 400, 20
    button #creator.female, "Female", [femaleClicked], UL, 25, 150, 200, 30
    button #creator.male, "Male", [maleClicked], UL, 225, 150, 200, 30
    textbox #creator.name, 25, 225, 400, 20
    'button #creator.random, "Random name", [randomClicked], UL, 25, 150, 200, 30
    button #creator.next, "Next", [nextClicked], UL, 325, 690, 100, 30
    button #creator.quit, "Back", [backClicked], UL, 25, 690, 100, 30
    WindowWidth = 460
    WindowHeight = 768
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)
    open "Character creation" for window as #creator
    print #creator.race, "Select your race"
    print #creator.gender, "Select your gender"
    Print #creator.name, "Name your character"
    wait

[humanClicked]

    let race$ = "Human"
    print #creator.race, "Human"
    wait

[unavailableClicked]

    statictext #unavailable.field, "This option is not yet available", 10, 15, 170, 20
    button #unavailable.ok, "OK", [unavailableokClicked], UL, 70, 40, 50, 30
    print #creator.race, " "
    WindowWidth = 200
    WindowHeight = 110
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)
    Open "Unavailable" for window as #unavailable
    wait

[unavailableokClicked]

    close #unavailable
    wait

[femaleClicked]

    let gender$ = "Female"
    print #creator.gender, "Female"
    wait

[maleClicked]

    let gender$ = "Male"
    print #creator.gender, "Male"
    wait

[nextClicked]

    if race$ = "Human" goto [raceOk]
    goto [raceNotOk]

[backClicked]

    close #creator
    wait

[raceOk]

    if gender$ = "Female" goto [genderOk]
    if gender$ = "Male" goto [genderOk]
    goto [genderNotOk]

[raceNotOk]

    statictext #raceNotOk.field, "You must select a race", 10, 15, 170, 20
    button #raceNotOk.ok, "OK", [raceNotOkokClicked], UL, 70, 40, 50, 30
    WindowWidth = 200
    WindowHeight = 110
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)
    Open "Select race" for window as #raceNotOk
    wait

[raceNotOkokClicked]

    close #raceNotOk
    wait

[charCreated]

    print #creator.name, "!contents?"
    input #creator.name, name$
    statictext #created.field1, name$, 10, 15, 170, 20
    statictext #created.field2, gender$, 10, 40, 170, 20
    statictext #created.field3, race$, 10, 65, 170, 20
    button #created.back, "Back", [createdBack], UL, 10, 130, 50, 30
    button #created.next, "Next", [createdNext], UL, 230, 130, 50, 30
    WindowWidth = 300
    WindowHeight = 200
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)
    Open "Character created" for window as #created
    let character$ = "ok"
    wait

[genderNotOk]

    statictext #genderNotOk.field, "You must select your gender", 10, 15, 170, 20
    button #genderNotOk.ok, "OK", [genderNotOkokClicked], UL, 70, 40, 50, 30
    WindowWidth = 200
    WindowHeight = 110
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)
    Open "Select gender" for window as #genderNotOk
    wait

[genderNotOkokClicked]

    close #genderNotOk
    wait

[createdBack]

    close #created
    wait

[genderOk]

    print #creator.name, "!contents?"
    input #creator.name, name$
    if name$ = "Name your character" goto [nameNotOk]
    if name$ = "" goto [nameNotOk]
    goto [charCreated]

[nameNotOk]

    statictext #nameNotOk.field, "You must name your character", 10, 15, 170, 20
    button #nameNotOk.ok, "OK", [nameNotOkokClicked], UL, 70, 40, 50, 30
    WindowWidth = 200
    WindowHeight = 110
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)
    Open "Name character" for window as #nameNotOk
    wait

[nameNotOkokClicked]

    close #nameNotOk
    wait

[createdNext]

    close #created
    close #creator
    goto [createdstart]
