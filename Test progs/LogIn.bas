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
    print #logIn.accountName, "testAccount"
    print #logIn.password, "testPassword"
    print #logIn.news, "Account is testAccount," + chr$(13) + chr$(10) + "Password is testPassword"
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

    open "myaccount.bin" for binary as #myaccount
    input #myaccount, myaccountname$
    close #myaccount
    print #logIn.accountName, "!contents?"
    input #logIn.accountName, accountName$
    print #logIn.password, "!contents?"
    input #logIn.password, accountpassword$
    if accountName$ = myaccountname$ goto [accountOk]
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

    open "mypassword.bin" for binary as #mypassword
    input #mypassword, mypassword$
    close #mypassword
    if accountpassword$ = mypassword$ goto [passwordOk]
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
    button #loggedIn.changePassword,"Change password",[ChangepasswordClick], UL,  224, 690, 202,  25
    button #loggedIn.exit,"Exit",[exitLoggedClick], UL,  21, 690, 101,  25
    button #loggedIn.play,"Play",[playClick], UL, 408, 575, 203,  25
    button #loggedIn.create,"Create character",[creator], UL, 408, 605, 203,  25
    button #loggedIn.delete,"Delete character",[deletor], UL, 408, 635, 203,  25
    textbox #loggedIn.news, 715, 103, 203, 202
    TextboxColor$ = "white"
    textbox #loggedIn.charName, 400, 520, 220,  25
    textbox #loggedIn.charCreated, 510, 545, 110,  25
    textbox #loggedIn.charRace, 400, 545, 110,  25
    statictext #loggedIn.character, "Character", 409,  54, 201,  25
    statictext #loggedIn.News, "News", 714,  54, 201,  25
    statictext #loggedIn.clientInfo, "Account info", 104,  53, 201,  25
    textbox #loggedIn.info1, 103, 102, 202,  25
    'textbox #loggedIn.info2, 103, 124, 202,  25
    'textbox #loggedIn.info3, 103, 146, 202,  25
    'textbox #loggedIn.info4, 103, 168, 202,  25
    open "Logged In" for window as #loggedIn

[createdstart]

    open "mycharcreated.bin" for binary as #mycharcreated
    open "mycharname.bin" for binary as #mycharname
    open "mycharrace.bin" for binary as #mycharrace
    input #mycharcreated, mycharcreated$
    input #mycharname, mycharname$
    input #mycharrace, mycharrace$
    close #mycharcreated
    close #mycharname
    close #mycharrace
    print #loggedIn.backGround, "getbmp logInBG 0 0 1024 768"
    print #loggedIn.backGround, "background logInBG";
    print #loggedIn.backGround, "drawsprites";
    print #loggedIn.characterPic, "down; fill white; flush"
    print #loggedIn.charName, mycharname$
    print #loggedIn.charCreated, mycharcreated$
    print #loggedIn.charRace, mycharrace$
    print #loggedIn, "font ms_sans_serif 10"
    print #loggedIn.info1, myaccountname$
    'print #loggedIn.info2,
    'print #loggedIn.info3,
    'print #loggedIn.info4,
    wait

[logOutClick]

  confirm "Log out?"; answer$
  if answer$ <> "yes" then wait
  close #loggedIn
  goto [start]

[playClick]

    open "character.bin" for binary as #character
    input #character, character$
    close #character
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

    open "character.bin" for binary as #character
    input #character, character$
    close #character
    if character$ = "ok" goto [charCreatedAllready]
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

[deletor]

    confirm "Delete character?"; answer$
    if answer$ <> "yes" then wait
    open "mycharcreated.bin" for binary as #mycharcreated
    open "mycharname.bin" for binary as #mycharname
    open "mycharrace.bin" for binary as #mycharrace
    open "mychargender.bin" for binary as #mychargender
    open "character.bin" for binary as #character
    blank$ = "                                                                     "
    print #mycharcreated, blank$
    print #mycharname, blank$
    print #mycharrace, blank$
    print #mychargender, blank$
    print #character, blank$
    close #mycharcreated
    close #mycharname
    close #mycharrace
    close #mychargender
    close #character
    goto [createdstart]

[charCreatedAllready]

    statictext #createdAllready.field, "Can't create more characters", 10, 15, 170, 20
    button #createdAllready.ok, "OK", [createdAllreadyokClicked], UL, 70, 40, 50, 30
    WindowWidth = 200
    WindowHeight = 110
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)
    Open "Character allready created" for window as #createdAllready
    wait

[createdAllreadyokClicked]

    close #createdAllready
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
    statictext #created.field4, date$ (), 10, 90, 170, 20
    open "mycharcreated.bin" for binary as #mycharcreated
    open "mycharname.bin" for binary as #mycharname
    open "mycharrace.bin" for binary as #mycharrace
    open "mychargender.bin" for binary as #mychargender
    open "character.bin" for binary as #character
    print #mycharcreated, date$ () + "                       "
    print #mycharname, name$ + "                       "
    print #mycharrace, race$ + "                       "
    print #mychargender, gender$ + "                       "
    print #character, "ok"
    close #mycharcreated
    close #mycharname
    close #mycharrace
    close #mychargender
    close #character
    button #created.back, "Back", [createdBack], UL, 10, 130, 50, 30
    button #created.next, "Next", [createdNext], UL, 230, 130, 50, 30
    WindowWidth = 300
    WindowHeight = 200
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)
    Open "Character created" for window as #created
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

[ChangepasswordClick]

    WindowWidth = 400
    WindowHeight = 230
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)
    button #changepassword.changepasswordok,"OK",[changepasswordokClick], UL,  99, 160, 100,  25
    button #changepassword.changepasswordcancel,"Cancel",[changepasswordcancelClick], UL, 201, 160, 100,  25
    TextboxColor$ = "white"
    textbox #changepassword.changepasswordnew,  50,  60, 300,  25
    textbox #changepassword.changepasswordconfirm,  50,  90, 300,  25
    open "Change password" for window as #changepassword
    print #changepassword, "font ms_sans_serif 10"
    print #changepassword.changepasswordnew, "Enter new password"
    print #changepassword.changepasswordconfirm, "Confirm new password"
    wait

[changepasswordokClick]

    print #changepassword.changepasswordnew, "!contents?"
    input #changepassword.changepasswordnew, newpassword$
    print #changepassword.changepasswordconfirm, "!contents?"
    input #changepassword.changepasswordconfirm, confirmpassword$
    open "mypassword.bin" for binary as #mypassword
    print #mypassword, confirmpassword$ + "                                                       "
    if newpassword$ <> confirmpassword$ goto [newpasswordnotok]
    close #mypassword
    statictext #passwordchanged.field, "Your password has been changed", 10, 15, 170, 20
    button #passwordchanged.ok, "OK", [passwordchangedokClicked], UL, 70, 40, 50, 30
    WindowWidth = 200
    WindowHeight = 110
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)
    Open "Password changed" for window as #passwordchanged
    wait

[changepasswordcancelClick]

    close #changepassword
    wait

[passwordchangedokClicked]

    close #passwordchanged
    close #changepassword
    wait

[newpasswordnotok]

    statictext #newpasswordnotok.field, "Password not confirmed", 10, 15, 170, 20
    button #newpasswordnotok.ok, "OK", [newpasswordnotokokClicked], UL, 70, 40, 50, 30
    WindowWidth = 200
    WindowHeight = 110
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)
    Open "Password not changed" for window as #newpasswordnotok
    wait

[newpasswordnotokokClicked]

    close #newpasswordnotok
    wait
