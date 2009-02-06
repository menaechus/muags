[start]

    nomainwin

    WindowWidth = 1024
    WindowHeight = 768
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)

    graphicbox #loggedIn.characterPic, 408, 102, 203, 409
    button #loggedIn.logOut,"Log out",[logOutClick], UL,  21, 690, 101,  25
    button #loggedIn.play,"Play",[playClick], UL, 408, 575, 203,  25
    button #loggedIn.create,"Create character",[creator], UL, 408, 620, 203,  25
    ListboxColor$ = "white"
    listbox #loggedIn.news, array$(, [],  715, 103, 203, 202
    TextboxColor$ = "white"
    textbox #loggedIn.charName, 408, 520, 203,  25
    textbox #loggedIn.charGender, 408, 545, 101,  25
    textbox #loggedIn.charRace, 510, 545, 101,  25
    textbox #loggedIn.character, 409,  54, 201,  25
    textbox #loggedIn.News, 714,  54, 201,  25
    textbox #loggedIn.clientInfo, 104,  53, 201,  25
    'textbox #loggedIn.info1, 103, 102, 202,  25
    'textbox #loggedIn.info2, 103, 124, 202,  25
    'textbox #loggedIn.info3, 103, 146, 202,  25
    'textbox #loggedIn.info4, 103, 168, 202,  25

    open "Logged In" for window as #loggedIn

[createdstart]

    print #loggedIn.characterPic, "down; fill white; flush"
    print #loggedIn, "font ms_sans_serif 10"
    print #loggedIn.character, "Character"
    print #loggedIn.News, "News"
    print #loggedIn.clientInfo, "Account info"
    'print #loggedIn.info1, accountname$
    'print #loggedIn.info2,
    'print #loggedIn.info3,
    'print #loggedIn.info4,
    print #loggedIn.charName, name$
    print #loggedIn.charGender, gender$
    print #loggedIn.charRace, race$

    wait




[logOutClick]

  confirm "Log out?"; answer$
  if answer$ <> "yes" then wait
  close #loggedIn
  end




[playClick]

    if character$ = "ok" goto [GameMap]
    goto [noCharCreated]




[noCharCreated]

    textbox #noCharCreated.field, 10, 15, 170, 20
    button #noCharCreated.ok, "OK", [noCharCreatedokClicked], UL, 70, 40, 50, 30

    WindowWidth = 200
    WindowHeight = 110
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)

    Open "Create a character" for window as #noCharCreated

    print #noCharCreated.field, "Create a character to play"

    wait





[noCharCreatedokClicked]

    close #noCharCreated

    wait





[GameMap]


    textbox #GameMap.field, 10, 15, 170, 20
    button #GameMap.ok, "Lopeta", [GameMapLopetaClicked], UL, 70, 40, 50, 30

    WindowWidth = 200
    WindowHeight = 110
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)

    Open "Nyt vois pelaa" for window as #GameMap

    print #GameMap.field, "Jos peli ois valmis"

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

    textbox #unavailable.field, 10, 15, 170, 20
    button #unavailable.ok, "OK", [unavailableokClicked], UL, 70, 40, 50, 30

    print #creator.race, " "

    WindowWidth = 200
    WindowHeight = 110
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)

    Open "Unavailable" for window as #unavailable

    print #unavailable.field, "This option is not yet available"

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

    textbox #raceNotOk.field, 10, 15, 170, 20
    button #raceNotOk.ok, "OK", [raceNotOkokClicked], UL, 70, 40, 50, 30

    WindowWidth = 200
    WindowHeight = 110
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)

    Open "Select race" for window as #raceNotOk

    print #raceNotOk.field, "You must select a race"

    wait




[raceNotOkokClicked]

    close #raceNotOk

    wait




[charCreated]

    print #creator.name, "!contents?"
    input #creator.name, name$

    textbox #created.field1, 10, 15, 170, 20
    textbox #created.field2, 10, 40, 170, 20
    textbox #created.field3, 10, 65, 170, 20
    button #created.back, "Back", [createdBack], UL, 10, 130, 50, 30
    button #created.next, "Next", [createdNext], UL, 230, 130, 50, 30

    WindowWidth = 300
    WindowHeight = 200
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)

    Open "Character created" for window as #created

    print #created.field1, name$
    print #created.field2, gender$
    print #created.field3, race$

    let character$ = "ok"

    wait




[genderNotOk]

    textbox #genderNotOk.field, 10, 15, 170, 20
    button #genderNotOk.ok, "OK", [genderNotOkokClicked], UL, 70, 40, 50, 30

    WindowWidth = 200
    WindowHeight = 110
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)

    Open "Select gender" for window as #genderNotOk

    print #genderNotOk.field, "You must select your gender"

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

    textbox #nameNotOk.field, 10, 15, 170, 20
    button #nameNotOk.ok, "OK", [nameNotOkokClicked], UL, 70, 40, 50, 30

    WindowWidth = 200
    WindowHeight = 110
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)

    Open "Name character" for window as #nameNotOk

    print #nameNotOk.field, "You must name your character"

    wait




[nameNotOkokClicked]

    close #nameNotOk

    wait




[createdNext]

    close #created
    close #creator
    goto [createdstart]
