
    mainwin 1024 768
    'WindowWidth = 1024
    'WindowHeight = 768
    'UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    'UpperLeftY=int((DisplayHeight-WindowHeight)/2)
    ' Yritin saada sen toisen screenin tollaseks, mut ei onnaa.

let inventory$ = "kiinni"

'Form created with the help of Freeform 3 v03-27-03
'Generated on Feb 08, 2009 at 12:41:33

mapfilee$ = DefaultDir$ + "\maps\"
mapfile$ = mapfilee$ + "map.1"

global PlayerLocX
global PlayerLocY
global cmd
dim dummy$(1000)
dim map1$(1000,1000)
PlayerLocX = 101
PlayerLocY = 100
x = 0
open mapfile$ for input as #1
[loop]

    input #1, dummy$(x)
    x = x + 1
    if eof(#1) = 0 then [loop]
close #1
x = x - 1
y = 0

xx = 0
yy = 0

    for xx = 0 to x
        for yy = 0 to 1000
        map1$(yy,xx) = mid$(dummy$(xx), yy, 1)
        'if map1$(xx,yy) = "" then yy = 1000
        next yy
    next xx

[setup.main.Window]

    '-----Begin code for #main
    'Map

    'nomainwin

    ctrl$ = chr$(_VK_CONTROL)
    print "Keys pressed:"
    WindowWidth = 550
    WindowHeight = 420
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)


    '-----Begin GUI objects code

    TexteditorColor$ = "white"
    texteditor #main.screen,   5,   5, 535, 325
    button #main.quit,"Quit",[quit.main], UL,   5, 335,  85,  25

    '-----End GUI objects code

    '-----Begin menu code

    menu #main, "Edit"  ' <-- Texteditor menu.


    '-----End menu code

    open "Main Map" for graphics_nf_nsb as #main
    print #main, "font Courier_New 12"
    print #main, "when characterInput [keyPressed]"
    print #main.screen, "!font Courier_New 12"
    print #main, "trapclose [quit.main]"


[main.inputLoop]   'wait here for input event
    print #main.screen, "!cls" ;
    rc = drawMap(PlayerLocX, PlayerLocY)
    print #main.screen, "Coordinates: " ; PlayerLocX; " : "; PlayerLocY
    print #main, "setfocus"
    scan
    wait

[keyPressed]
    key$ = left$(Inkey$, 2)
    print key$
    select case key$
        case "1"
            command$ = key$
        case "2"
            command$ = key$ 
        case "3"
            command$ = key$
        case "4"
            command$ = key$
        case "6"
            command$ = key$
        case "7"
            command$ = key$
        case "8"
            command$ = key$
        case "9"
            command$ = key$
        case "w"
            command$ = key$
        case "a"
            command$ = key$
        case "s"
            command$ = key$
        case "d"
            command$ = key$
        case "i"
            goto [inventory]
        case else
            goto [main.inputLoop]
    end select
    call CheckCmd command$ 
    if cmd <> 0 then a = MovePlayer(cmd)
    goto [main.inputLoop]

[inventory]

    if inventory$ = "auki" goto [closeInventoryClick]

    WindowWidth = 300
    WindowHeight = 768
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)

    graphicbox #inventory.characterPic,  80,  80, 130, 200
    TextboxColor$ = "white"
    textbox #inventory.characterName,  80,  54, 130,  30
    button #inventory.close,"Close",[closeInventoryClick], UL, 199, 711,  90,  25

    open "Inventory" for window as #inventory
    print #inventory.characterPic, "down; fill white; flush"
    print #inventory, "font ms_sans_serif 10"
    let inventory$ = "auki"

    goto [main.inputLoop]

[closeInventoryClick]

    let inventory$ = "kiinni"
    close #inventory
    goto [main.inputLoop]


[quit.main] 'End the program

    if inventory$ = "auki" then close #inventory
    close #main
    end

'---Subs---

sub CheckCmd command$
    cmd = 0
    if command$ = "7" then cmd = 1
    if command$ = "8" then cmd = 2
    if command$ = "9" then cmd = 3
    if command$ = "4" then cmd = 4
    if command$ = "6" then cmd = 5
    if command$ = "1" then cmd = 6
    if command$ = "2" then cmd = 7
    if command$ = "3" then cmd = 8
    if command$ = "w" then cmd = 9
    if command$ = "a" then cmd = 10
    if command$ = "s" then cmd = 12
    if command$ = "d" then cmd = 11
    'if command$ = "i" then cmd = 20
end sub


'---Funcs---
function MovePlayer(cmd)
OldX = PlayerLocX
OldY = PlayerLocY
if cmd = 1 then PlayerLocY = PlayerLocY - 1
if cmd = 1 then PlayerLocX = PlayerLocX - 1
if cmd = 2 then PlayerLocY = PlayerLocY - 1
if cmd = 3 then PlayerLocY = PlayerLocY - 1
if cmd = 3 then PlayerLocX = PlayerLocX + 1
if cmd = 4 then PlayerLocX = PlayerLocX - 1
if cmd = 5 then PlayerLocX = PlayerLocX + 1
if cmd = 6 then PlayerLocY = PlayerLocY + 1
if cmd = 6 then PlayerLocX = PlayerLocX - 1
if cmd = 7 then PlayerLocY = PlayerLocY + 1
if cmd = 8 then PlayerLocY = PlayerLocY + 1
if cmd = 8 then PlayerLocX = PlayerLocX + 1
if cmd = 9 then PlayerLocY = PlayerLocY - 1
if cmd = 10 then PlayerLocX = PlayerLocX - 1
if cmd = 11 then PlayerLocX = PlayerLocX + 1
if cmd = 12 then PlayerLocY = PlayerLocY + 1
'if cmd = 20 goto [inventory]
if PlayerLocX < 0 then PlayerLocX = 0
if PlayerLocY < 0 then PlayerLocY = 0
if map1$(PlayerLocX, PlayerLocY) = "#" then
    PlayerLocX = OldX
    PlayerLocY = OldY
end if
if map1$(PlayerLocX, PlayerLocY) = "w" then
    PlayerLocX = OldX
    PlayerLocY = OldY
end if
if map1$(PlayerLocX, PlayerLocY) = "r" then
    PlayerLocX = OldX
    PlayerLocY = OldY
end if


end function

function drawMap(PlayerLocX, PlayerLocY)

    one$ = ""
    two$ = ""
    three$ = ""
    four$ = ""
    six$ = ""
    seven$ = ""
    eight$ = ""
    nine$ = ""
    ten$ = ""
    eleven$ = ""
    twelve$ = ""
    thirteen$ = ""
    fourteen$ = ""
    fifteen$ = ""
    sixteen$ = ""
    seventeen$ = ""
    eighteen$ = ""
    nineteen$ = ""
    twenty$ = ""
    twentyone$ = ""
    twentytwo$ = ""
    twentythree$ = ""
    twentyfour$ = ""
    twentyfive$ = ""
    twentysix$ = ""
    twentyseven$ = ""
    twentyeight$ = ""
    twentynine$ = ""
    thirty$ = ""
    thirtyone$ = ""
    thirtytwo$ = ""
    thirtythree$ = ""
    thirtyfour$ = ""
    thirtyfive$ = ""
    thirtysix$ = ""
    thirtyseven$ = ""
    thirtyeight$ = ""
    thirtynine$ = ""
    fourty$ = ""
    fourtyone$ = ""
    fourtytwo$ = ""
    fourtythree$ = ""
    fourtyfour$ = ""
    fourtyfive$ = ""
    fourtysix$ = ""
    fourtyseven$ = ""
    fourtyeight$ = ""
    fourtynine$ = ""
    fifty$ = ""
    fiftyone$ = ""
    fiftytwo$ = ""
    fiftythree$ = ""
    fiftyfour$ = ""
    fiftyfive$ = ""
    fiftysix$ = ""
    fiftyseven$ = ""
    fiftyeight$ = ""
    fiftynine$ = ""
    sixty$ = ""
    sixtyone$ = ""
    sixtytwo$ = ""
    sixtythree$ = ""
    sixtyfour$ = ""
    sixtyfive$ = ""
    sixtysix$ = ""
    sixtyseven$ = ""
    sixtyeight$ = ""
    sixtynine$ = ""
    seventy$ = ""
    seventyone$ = ""
    seventytwo$ = ""
    seventythree$ = ""
    seventyfour$ = ""
    seventyfive$ = ""
    seventysix$ = ""
    seventyseven$ = ""
    seventyeight$ = ""
    seventynine$ = ""
    eighty$ = ""
    eightyone$ = ""
    eightytwo$ = ""
    eightythree$ = ""
    eightyfour$ = ""
    eightyfive$ = ""
    eightysix$ = ""
    eightyseven$ = ""
    eightyeight$ = ""
    eightynine$ = ""
    ninety$ = ""
    ninetyone$ = ""
    ninetytwo$ = ""
    ninetythree$ = ""
    ninetyfour$ = ""
    ninetyfive$ = ""
    ninetysix$ = ""
    ninetyseven$ = ""
    ninetyeight$ = ""
    ninetynine$ = ""
    onehundred$ = ""
    onehundredone$ = ""
    onehundredtwo$ = ""
    onehundredthree$ = ""
    onehundredfour$ = ""
    onehundredfive$ = ""
    onehundredsix$ = ""
    onehundredseven$ = ""
    onehundredeight$ = ""
    onehundrednine$ = ""
    onehundredten$ = ""
    oneeleven$ = ""
    onetwelve$ = ""
    onethirteen$ = ""
    onefourteen$ = ""
    onefifteen$ = ""
    onesixteen$ = ""
    oneseventeen$ = ""
    oneeighteen$ = ""
    onenineteen$ = ""
    onetwenty$ = ""
    onetwentyone$ = ""

    oneX = PlayerLocX - 1
    oneY = PlayerLocY - 1
    if oneX < 0 then oneX = 1
    if oneY < 0 then oneY = 0
    one$ = map1$(oneX, oneY)

    twoX = PlayerLocX
    twoY = PlayerLocY - 1
    if twoX < 0 then twoX = 1
    if twoY < 0 then twoY = 0
    two$ = map1$(twoX, twoY)

    threeX = PlayerLocX + 1
    threeY = PlayerLocY - 1
    if threeX < 0 then threeX = 1
    if threeY < 0 then threeY = 0
    three$ = map1$(threeX, threeY)

    fourX = PlayerLocX - 1
    fourY = PlayerLocY
    if fourX < 0 then fourX = 1
    if fourY < 0 then fourY = 0
    four$ = map1$(fourX, fourY)

    sixX = PlayerLocX + 1
    sixY = PlayerLocY
    if sixX < 0 then sixX = 1
    if sixY < 0 then sixY = 0
    six$ = map1$(sixX, sixY)

    sevenX = PlayerLocX - 1
    sevenY = PlayerLocY + 1
    if sevenX < 0 then sevenX = 1
    if sevenY < 0 then sevenY = 0
    seven$ = map1$(sevenX, sevenY)

    eightX = PlayerLocX
    eightY = PlayerLocY + 1
    if eightX < 0 then eightX = 1
    if eightY < 0 then eightY = 0
    eight$ = map1$(eightX, eightY)

    nineX = PlayerLocX + 1
    nineY = PlayerLocY + 1
    if nineX < 0 then nineX = 1
    if nineY < 0 then nineY = 0
    nine$ = map1$(nineX, nineY)

    tenX = PlayerLocX - 2
    tenY = PlayerLocY - 2
    if tenX < 0 then tenX = 0
    if tenY < 0 then tenY = 0
    ten$ = map1$(tenX, tenY)

    elevenX = PlayerLocX - 1
    elevenY = PlayerLocY - 2
    if elevenX < 0 then elevenX = 0
    if elevenY < 0 then elevenY = 0
    eleven$ = map1$(elevenX, elevenY)

    twelveX = PlayerLocX
    twelveY = PlayerLocY - 2
    if twelveY < 0 then twelveY = 0
    twelve$ = map1$(twelveX, twelveY)

    thirteenX = PlayerLocX + 1
    thirteenY = PlayerLocY - 2
    if thirteenX < 0 then thirteenX = 0
    if thirteenY < 0 then thirteenY = 0
    thirteen$ = map1$(thirteenX, thirteenY)

    fourteenX = PlayerLocX + 2
    fourteenY = PlayerLocY - 2
    if fourteenX < 0 then fourteenX = 0
    if fourteenY < 0 then fourteenY = 0
    fourteen$ = map1$(fourteenX, fourteenY)

    fifteenX = PlayerLocX - 2
    fifteenY = PlayerLocY - 1
    if fifteenX < 0 then fifteenX = 0
    if fifteenY < 0 then fifteenY = 0
    fifteen$ = map1$(fifteenX, fifteenY)

    sixteenX = PlayerLocX + 2
    sixteenY = PlayerLocY - 1
    if sixteenX < 0 then sixteenX = 0
    if sixteenY < 0 then sixteenY = 0
    sixteen$ = map1$(sixteenX, sixteenY)

    seventeenX = PlayerLocX - 2
    seventeenY = PlayerLocY
    if seventeenX < 0 then seventeenX = 0
    seventeen$ = map1$(seventeenX, seventeenY)

    eighteenX = PlayerLocX + 2
    eighteenY = PlayerLocY
    if eighteenX < 0 then eighteenX = 0
    eighteen$ = map1$(eighteenX, eighteenY)

    nineteenX = PlayerLocX - 2
    nineteenY = PlayerLocY + 1
    if nineteenX < 0 then nineteenX = 0
    if nineteenY < 0 then nineteenY = 0
    nineteen$ = map1$(nineteenX, nineteenY)

    twentyX = PlayerLocX + 2
    twentyY = PlayerLocY + 1
    if twentyX < 0 then twentyX = 0
    if twentyY < 0 then twentyY = 0
    twenty$ = map1$(twentyX, twentyY)

    twentyoneX = PlayerLocX - 2
    twentyoneY = PlayerLocY + 2
    if twentyoneX < 0 then twentyoneX = 0
    if twentyoneY < 0 then twentyoneY = 0
    twentyone$ = map1$(twentyoneX, twentyoneY)

    twentytwoX = PlayerLocX - 1
    twentytwoY = PlayerLocY + 2
    if twentytwoX < 0 then twentytwoX = 0
    if twentytwoY < 0 then twentytwoY = 0
    twentytwo$ = map1$(twentytwoX, twentytwoY)

    twentythreeX = PlayerLocX
    twentythreeY = PlayerLocY + 2
    if twentythreeY < 0 then twentythreeY = 0
    twentythree$ = map1$(twentythreeX, twentythreeY)

    twentyfourX = PlayerLocX + 1
    twentyfourY = PlayerLocY + 2
    if twentyfourX < 0 then twentyfourX = 0
    if twentyfourY < 0 then twentyfourY = 0
    twentyfour$ = map1$(twentyfourX, twentyfourY)

    twentyfiveX = PlayerLocX + 2
    twentyfiveY = PlayerLocY + 2
    if twentyfiveX < 0 then twentyfiveX = 0
    if twentyfiveY < 0 then twentyfiveY = 0
    twentyfive$ = map1$(twentyfiveX, twentyfiveY)

    twentysixX = PlayerLocX - 3
    twentysixY = PlayerLocY - 3
    if twentysixX < 0 then twentysixX = 0
    if twentysixY < 0 then twentysixY = 0
    twentysix$ = map1$(twentysixX, twentysixY)

    twentysevenX = PlayerLocX - 2
    twentysevenY = PlayerLocY - 3
    if twentysevenX < 0 then twentysevenX = 0
    if twentysevenY < 0 then twentysevenY = 0
    twentyseven$ = map1$(twentysevenX, twentysevenY)

    twentyeightX = PlayerLocX - 1
    twentyeightY = PlayerLocY - 3
    if twentyeightX < 0 then twentyeightX = 0
    if twentyeightY < 0 then twentyeightY = 0
    twentyeight$ = map1$(twentyeightX, twentyeightY)

    twentynineX = PlayerLocX
    twentynineY = PlayerLocY - 3
    if twentynineY < 0 then twentynineY = 0
    twentynine$ = map1$(twentynineX, twentynineY)

    thirtyX = PlayerLocX + 1
    thirtyY = PlayerLocY - 3
    if thirtyX < 0 then thirtyX = 0
    if thirtyY < 0 then thirtyY = 0
    thirty$ = map1$(thirtyX, thirtyY)

    thirtyoneX = PlayerLocX + 2
    thirtyoneY = PlayerLocY - 3
    if thirtyoneX < 0 then thirtyoneX = 0
    if thirtyoneY < 0 then thirtyoneY = 0
    thirtyone$ = map1$(thirtyoneX, thirtyoneY)

    thirtytwoX = PlayerLocX + 3
    thirtytwoY = PlayerLocY - 3
    if thirtytwoX < 0 then thirtytwoX = 0
    if thirtytwoY < 0 then thirtytwoY = 0
    thirtytwo$ = map1$(thirtytwoX, thirtytwoY)

    thirtythreeX = PlayerLocX - 3
    thirtythreeY = PlayerLocY - 2
    if thirtythreeX < 0 then thirtythreeX = 0
    if thirtythreeY < 0 then thirtythreeY = 0
    thirtythree$ = map1$(thirtythreeX, thirtythreeY)

    thirtyfourX = PlayerLocX + 3
    thirtyfourY = PlayerLocY - 2
    if thirtyfourX < 0 then thirtyfourX = 0
    if thirtyfourY < 0 then thirtyfourY = 0
    thirtyfour$ = map1$(thirtyfourX, thirtyfourY)

    thirtyfiveX = PlayerLocX - 3
    thirtyfiveY = PlayerLocY - 1
    if thirtyfiveX < 0 then thirtyfiveX = 0
    if thirtyfiveY < 0 then thirtyfiveY = 0
    thirtyfive$ = map1$(thirtyfiveX, thirtyfiveY)

    thirtysixX = PlayerLocX + 3
    thirtysixY = PlayerLocY - 1
    if thirtysixX < 0 then thirtysixX = 0
    if thirtysixY < 0 then thirtysixY = 0
    thirtysix$ = map1$(thirtysixX, thirtysixY)

    thirtysevenX = PlayerLocX - 3
    thirtysevenY = PlayerLocY
    if thirtysevenX < 0 then thirtysevenX = 0
    thirtyseven$ = map1$(thirtysevenX, thirtysevenY)

    thirtyeightX = PlayerLocX + 3
    thirtyeightY = PlayerLocY
    if thirtyeightX < 0 then thirtyeightX = 0
    thirtyeight$ = map1$(thirtyeightX, thirtyeightY)

    thirtynineX = PlayerLocX - 3
    thirtynineY = PlayerLocY + 1
    if thirtynineX < 0 then thirtynineX = 0
    if thirtynineY < 0 then thirtynineY = 0
    thirtynine$ = map1$(thirtynineX, thirtynineY)

    fourtyX = PlayerLocX + 3
    fourtyY = PlayerLocY + 1
    if fourtyX < 0 then fourtyX = 0
    if fourtyY < 0 then fourtyY = 0
    fourty$ = map1$(fourtyX, fourtyY)

    fourtyoneX = PlayerLocX - 3
    fourtyoneY = PlayerLocY + 2
    if fourtyoneX < 0 then fourtyoneX = 0
    if fourtyoneY < 0 then fourtyoneY = 0
    fourtyone$ = map1$(fourtyoneX, fourtyoneY)

    fourtytwoX = PlayerLocX + 3
    fourtytwoY = PlayerLocY + 2
    if fourtytwoX < 0 then fourtytwoX = 0
    if fourtytwoY < 0 then fourtytwoY = 0
    fourtytwo$ = map1$(fourtytwoX, fourtytwoY)

    fourtythreeX = PlayerLocX - 3
    fourtythreeY = PlayerLocY + 3
    if fourtythreeX < 0 then fourtythreeX = 0
    if fourtythreeY < 0 then fourtythreeY = 0
    fourtythree$ = map1$(fourtythreeX, fourtythreeY)

    fourtyfourX = PlayerLocX - 2
    fourtyfourY = PlayerLocY + 3
    if fourtyfourX < 0 then fourtyfourX = 0
    if fourtyfourY < 0 then fourtyfourY = 0
    fourtyfour$ = map1$(fourtyfourX, fourtyfourY)

    fourtyfiveX = PlayerLocX - 1
    fourtyfiveY = PlayerLocY + 3
    if fourtyfiveX < 0 then fourtyfiveX = 0
    if fourtyfiveY < 0 then fourtyfiveY = 0
    fourtyfive$ = map1$(fourtyfiveX, fourtyfiveY)

    fourtysixX = PlayerLocX
    fourtysixY = PlayerLocY + 3
    if fourtysixY < 0 then fourtysixY = 0
    fourtysix$ = map1$(fourtysixX, fourtysixY)

    fourtysevenX = PlayerLocX + 1
    fourtysevenY = PlayerLocY + 3
    if fourtysevenX < 0 then fourtysevenX = 0
    if fourtysevenY < 0 then fourtysevenY = 0
    fourtyseven$ = map1$(fourtysevenX, fourtysevenY)

    fourtyeightX = PlayerLocX + 2
    fourtyeightY = PlayerLocY + 3
    if fourtyeightX < 0 then fourtyeightX = 0
    if fourtyeightY < 0 then fourtyeightY = 0
    fourtyeight$ = map1$(fourtyeightX, fourtyeightY)

    fourtynineX = PlayerLocX + 3
    fourtynineY = PlayerLocY + 3
    if fourtynineX < 0 then fourtynineX = 0
    if fourtynineY < 0 then fourtynineY = 0
    fourtynine$ = map1$(fourtynineX, fourtynineY)

    fiftyX = PlayerLocX - 4
    fiftyY = PlayerLocY - 4
    if fiftyX < 0 then fiftyX = 0
    if fiftyY < 0 then fiftyY = 0
    fifty$ = map1$(fiftyX, fiftyY)

    fiftyoneX = PlayerLocX - 3
    fiftyoneY = PlayerLocY - 4
    if fiftyoneX < 0 then fiftyoneX = 0
    if fiftyoneY < 0 then fiftyoneY = 0
    fiftyone$ = map1$(fiftyoneX, fiftyoneY)

    fiftytwoX = PlayerLocX - 2
    fiftytwoY = PlayerLocY - 4
    if fiftytwoX < 0 then fiftytwoX = 0
    if fiftytwoY < 0 then fiftytwoY = 0
    fiftytwo$ = map1$(fiftytwoX, fiftytwoY)

    fiftythreeX = PlayerLocX - 1
    fiftythreeY = PlayerLocY - 4
    if fiftythreeX < 0 then fiftythreeX = 0
    if fiftythreeY < 0 then fiftythreeY = 0
    fiftythree$ = map1$(fiftythreeX, fiftythreeY)

    fiftyfourX = PlayerLocX
    fiftyfourY = PlayerLocY -4
    if fiftyfourY < 0 then fiftyfourY = 0
    fiftyfour$ = map1$(fiftyfourX, fiftyfourY)

    fiftyfiveX = PlayerLocX + 1
    fiftyfiveY = PlayerLocY - 4
    if fiftyfiveX < 0 then fiftyfiveX = 0
    if fiftyfiveY < 0 then fiftyfiveY = 0
    fiftyfive$ = map1$(fiftyfiveX, fiftyfiveY)

    fiftysixX = PlayerLocX + 2
    fiftysixY = PlayerLocY - 4
    if fiftysixX < 0 then fiftysixX = 0
    if fiftysixY < 0 then fiftysixY = 0
    fiftysix$ = map1$(fiftysixX, fiftysixY)

    fiftysevenX = PlayerLocX + 3
    fiftysevenY = PlayerLocY - 4
    if fiftysevenX < 0 then fiftysevenX = 0
    if fiftysevenY < 0 then fiftysevenY = 0
    fiftyseven$ = map1$(fiftysevenX, fiftysevenY)

    fiftyeightX = PlayerLocX + 4
    fiftyeightY = PlayerLocY - 4
    if fiftyeightX < 0 then fiftyeightX = 0
    if fiftyeightY < 0 then fiftyeightY = 0
    fiftyeight$ = map1$(fiftyeightX, fiftyeightY)

    fiftynineX = PlayerLocX - 4
    fiftynineY = PlayerLocY - 3
    if fiftynineX < 0 then fiftynineX = 0
    if fiftynineY < 0 then fiftynineY = 0
    fiftynine$ = map1$(fiftynineX, fiftynineY)

    sixtyX = PlayerLocX + 4
    sixtyY = PlayerLocY - 3
    if sixtyX < 0 then sixtyX = 0
    if sixtyY < 0 then sixtyY = 0
    sixty$ = map1$(sixtyX, sixtyY)

    sixtyoneX = PlayerLocX - 4
    sixtyoneY = PlayerLocY - 2
    if sixtyoneX < 0 then sixtyoneX = 0
    if sixtyoneY < 0 then sixtyoneY = 0
    sixtyone$ = map1$(sixtyoneX, sixtyoneY)

    sixtytwoX = PlayerLocX + 4
    sixtytwoY = PlayerLocY - 2
    if sixtytwoX < 0 then sixtytwoX = 0
    if sixtytwoY < 0 then sixtytwoY = 0
    sixtytwo$ = map1$(sixtytwoX, sixtytwoY)

    sixtythreeX = PlayerLocX - 4
    sixtythreeY = PlayerLocY - 1
    if sixtythreeX < 0 then sixtythreeX = 0
    if sixtythreeY < 0 then sixtythreeY = 0
    sixtythree$ = map1$(sixtythreeX, sixtythreeY)

    sixtyfourX = PlayerLocX + 4
    sixtyfourY = PlayerLocY - 1
    if sixtyfourX < 0 then sixtyfourX = 0
    if sixtyfourY < 0 then sixtyfourY = 0
    sixtyfour$ = map1$(sixtyfourX, sixtyfourY)

    sixtyfiveX = PlayerLocX - 4
    sixtyfiveY = PlayerLocY
    if sixtyfiveX < 0 then sixtyfiveX = 0
    sixtyfive$ = map1$(sixtyfiveX, sixtyfiveY)

    sixtysixX = PlayerLocX + 4
    sixtysixY = PlayerLocY
    if sixtysixX < 0 then sixtysixX = 0
    sixtysix$ = map1$(sixtysixX, sixtysixY)

    sixtysevenX = PlayerLocX - 4
    sixtysevenY = PlayerLocY + 1
    if sixtysevenX < 0 then sixtysevenX = 0
    if sixtysevenY < 0 then sixtysevenY = 0
    sixtyseven$ = map1$(sixtysevenX, sixtysevenY)

    sixtyeightX = PlayerLocX + 4
    sixtyeightY = PlayerLocY + 1
    if sixtyeightX < 0 then sixtyeightX = 0
    if sixtyeightY < 0 then sixtyeightY = 0
    sixtyeight$ = map1$(sixtyeightX, sixtyeightY)

    sixtynineX = PlayerLocX - 4
    sixtynineY = PlayerLocY + 2
    if sixtynineX < 0 then sixtynineX = 0
    if sixtynineY < 0 then sixtynineY = 0
    sixtynine$ = map1$(sixtynineX, sixtynineY)

    seventyX = PlayerLocX + 4
    seventyY = PlayerLocY + 2
    if seventyX < 0 then seventyX = 0
    if seventyY < 0 then seventyY = 0
    seventy$ = map1$(seventyX, seventyY)

    seventyoneX = PlayerLocX - 4
    seventyoneY = PlayerLocY + 3
    if seventyoneX < 0 then seventyoneX = 0
    if seventyoneY < 0 then seventyoneY = 0
    seventyone$ = map1$(seventyoneX, seventyoneY)

    seventytwoX = PlayerLocX + 4
    seventytwoY = PlayerLocY + 3
    if seventytwoX < 0 then seventytwoX = 0
    if seventytwoY < 0 then seventytwoY = 0
    seventytwo$ = map1$(seventytwoX, seventytwoY)

    seventythreeX = PlayerLocX - 4
    seventythreeY = PlayerLocY + 4
    if seventythreeX < 0 then seventythreeX = 0
    if seventythreeY < 0 then seventythreeY = 0
    seventythree$ = map1$(seventythreeX, seventythreeY)

    seventyfourX = PlayerLocX - 3
    seventyfourY = PlayerLocY + 4
    if seventyfourX < 0 then seventyX = 0
    if seventyfourY < 0 then seventyY = 0
    seventyfour$ = map1$(seventyfourX, seventyfourY)

    seventyfiveX = PlayerLocX - 2
    seventyfiveY = PlayerLocY + 4
    if seventyfiveX < 0 then seventyfiveX = 0
    if seventyfiveY < 0 then seventyfiveY = 0
    seventyfive$ = map1$(seventyfiveX, seventyfiveY)

    seventysixX = PlayerLocX - 1
    seventysixY = PlayerLocY + 4
    if seventysixX < 0 then seventysixX = 0
    if seventysixY < 0 then seventysixY = 0
    seventysix$ = map1$(seventysixX, seventysixY)

    seventysevenX = PlayerLocX
    seventysevenY = PlayerLocY + 4
    if seventysevenY < 0 then seventysevenY = 0
    seventyseven$ = map1$(seventysevenX, seventysevenY)

    seventyeightX = PlayerLocX + 1
    seventyeightY = PlayerLocY + 4
    if seventyeightX < 0 then seventyeightX = 0
    if seventyeightY < 0 then seventyeightY = 0
    seventyeight$ = map1$(seventyeightX, seventyeightY)

    seventynineX = PlayerLocX + 2
    seventynineY = PlayerLocY + 4
    if seventynineX < 0 then seventynineX = 0
    if seventynineY < 0 then seventynineY = 0
    seventynine$ = map1$(seventynineX, seventynineY)

    eightyX = PlayerLocX + 3
    eightyY = PlayerLocY + 4
    if eightyX < 0 then eightyX = 0
    if eightyY < 0 then eightyY = 0
    eighty$ = map1$(eightyX, eightyY)

    eightyoneX = PlayerLocX + 4
    eightyoneY = PlayerLocY + 4
    if eightyoneX < 0 then eightyoneX = 0
    if eightyoneY < 0 then eightyoneY = 0
    eightyone$ = map1$(eightyoneX, eightyoneY)

    eightytwoX = PlayerLocX - 5
    eightytwoY = PlayerLocY - 5
    if eightytwoX < 0 then eightytwoX = 0
    if eightytwoY < 0 then eightytwoY = 0
    eightytwo$ = map1$(eightytwoX, eightytwoY)

    eightythreeX = PlayerLocX - 4
    eightythreeY = PlayerLocY - 5
    if eightythreeX < 0 then eightythreeX = 0
    if eightythreeY < 0 then eightythreeY = 0
    eightythree$ = map1$(eightythreeX, eightythreeY)

    eightyfourX = PlayerLocX - 3
    eightyfourY = PlayerLocY - 5
    if eightyfourX < 0 then eightyfourX = 0
    if eightyfourY < 0 then eightyfourY = 0
    eightyfour$ = map1$(eightyfourX, eightyfourY)

    eightyfiveX = PlayerLocX - 2
    eightyfiveY = PlayerLocY - 5
    if eightyfiveX < 0 then eightyfiveX = 0
    if eightyfiveY < 0 then eightyfiveY = 0
    eightyfive$ = map1$(eightyfiveX, eightyfiveY)

    eightysixX = PlayerLocX - 1
    eightysixY = PlayerLocY - 5
    if eightysixX < 0 then eightysixX = 0
    if eightysixY < 0 then eightysixY = 0
    eightysix$ = map1$(eightysixX, eightysixY)

    eightysevenX = PlayerLocX
    eightysevenY = PlayerLocY - 5
    if eightysevenY < 0 then eightysevenY = 0
    eightyseven$ = map1$(eightysevenX, eightysevenY)

    eightyeightX = PlayerLocX + 1
    eightyeightY = PlayerLocY - 5
    if eightyeightX < 0 then eightyeightX = 0
    if eightyeightY < 0 then eightyeightY = 0
    eightyeight$ = map1$(eightyeightX, eightyeightY)

    eightynineX = PlayerLocX + 2
    eightynineY = PlayerLocY - 5
    if eightynineX < 0 then eightynineX = 0
    if eightynineY < 0 then eightynineY = 0
    eightynine$ = map1$(eightynineX, eightynineY)

    ninetyX = PlayerLocX + 3
    ninetyY = PlayerLocY - 5
    if ninetyX < 0 then ninetyX = 0
    if ninetyY < 0 then ninetyY = 0
    ninety$ = map1$(ninetyX, ninetyY)

    ninetyoneX = PlayerLocX + 4
    ninetyoneY = PlayerLocY - 5
    if ninetyoneX < 0 then ninetyoneX = 0
    if ninetyoneY < 0 then ninetyoneY = 0
    ninetyone$ = map1$(ninetyoneX, ninetyoneY)

    ninetytwoX = PlayerLocX + 5
    ninetytwoY = PlayerLocY - 5
    if ninetytwoX < 0 then ninetytwoX = 0
    if ninetytwoY < 0 then ninetytwoY = 0
    ninetytwo$ = map1$(ninetytwoX, ninetytwoY)

    ninetythreeX = PlayerLocX - 5
    ninetythreeY = PlayerLocY - 4
    if ninetythreeX < 0 then ninetythreeX = 0
    if ninetythreeY < 0 then ninetythreeY = 0
    ninetythree$ = map1$(ninetythreeX, ninetythreeY)

    ninetyfourX = PlayerLocX + 5
    ninetyfourY = PlayerLocY - 4
    if ninetyfourX < 0 then ninetyfourX = 0
    if ninetyfourY < 0 then ninetyfourY = 0
    ninetyfour$ = map1$(ninetyfourX, ninetyfourY)

    ninetyfiveX = PlayerLocX - 5
    ninetyfiveY = PlayerLocY - 3
    if ninetyfiveX < 0 then ninetyfiveX = 0
    if ninetyfiveY < 0 then ninetyfiveY = 0
    ninetyfive$ = map1$(ninetyfiveX, ninetyfiveY)

    ninetysixX = PlayerLocX + 5
    ninetysixY = PlayerLocY - 3
    if ninetysixX < 0 then ninetysixX = 0
    if ninetysixY < 0 then ninetysixY = 0
    ninetysix$ = map1$(ninetysixX, ninetysixY)

    ninetysevenX = PlayerLocX - 5
    ninetysevenY = PlayerLocY - 2
    if ninetysevenX < 0 then ninetysevenX = 0
    if ninetysevenY < 0 then ninetysevenY = 0
    ninetyseven$ = map1$(ninetysevenX, ninetysevenY)

    ninetyeightX = PlayerLocX + 5
    ninetyeightY = PlayerLocY - 2
    if ninetyeightX < 0 then ninetyeightX = 0
    if ninetyeightY < 0 then ninetyeightY = 0
    ninetyeight$ = map1$(ninetyeightX, ninetyeightY)

    ninetynineX = PlayerLocX - 5
    ninetynineY = PlayerLocY - 1
    if ninetynineX < 0 then ninetynineX = 0
    if ninetynineY < 0 then ninetynineY = 0
    ninetynine$ = map1$(ninetynineX, ninetynineY)

    onehundredX = PlayerLocX + 5
    onehundredY = PlayerLocY - 1
    if onehundredX < 0 then onehundredX = 0
    if onehundredY < 0 then onehundredY = 0
    onehundred$ = map1$(onehundredX, onehundredY)

    onehundredoneX = PlayerLocX - 5
    onehundredoneY = PlayerLocY
    if onehundredoneX < 0 then onehundredoneX = 0
    onehundredone$ = map1$(onehundredoneX, onehundredoneY)

    onehundredtwoX = PlayerLocX + 5
    onehundredtwoY = PlayerLocY
    if onehundredtwoX < 0 then onehundredtwoX = 0
    onehundredtwo$ = map1$(onehundredtwoX, onehundredtwoY)

    onehundredthreeX = PlayerLocX - 5
    onehundredthreeY = PlayerLocY + 1
    if onehundredthreeX < 0 then onehundredthreeX = 0
    if onehundredthreeY < 0 then onehundredthreeY = 0
    onehundredthree$ = map1$(onehundredthreeX, onehundredthreeY)

    onehundredfourX = PlayerLocX + 5
    onehundredfourY = PlayerLocY + 1
    if onehundredfourX < 0 then onehundredfourX = 0
    if onehundredfourY < 0 then onehundredfourY = 0
    onehundredfour$ = map1$(onehundredfourX, onehundredfourY)

    onehundredfiveX = PlayerLocX - 5
    onehundredfiveY = PlayerLocY + 2
    if onehundredfiveX < 0 then onehundredfiveX = 0
    if onehundredfiveY < 0 then onehundredfiveY = 0
    onehundredfive$ = map1$(onehundredfiveX, onehundredfiveY)

    onehundredsixX = PlayerLocX + 5
    onehundredsixY = PlayerLocY + 2
    if onehundredsixX < 0 then onehundredsixX = 0
    if onehundredsixY < 0 then onehundredsixY = 0
    onehundredsix$ = map1$(onehundredsixX, onehundredsixY)

    onehundredsevenX = PlayerLocX - 5
    onehundredsevenY = PlayerLocY + 3
    if onehundredsevenX < 0 then onehundredsevenX = 0
    if onehundredsevenY < 0 then onehundredsevenY = 0
    onehundredseven$ = map1$(onehundredsevenX, onehundredsevenY)

    onehundredeightX = PlayerLocX + 5
    onehundredeightY = PlayerLocY + 3
    if onehundredeightX < 0 then onehundredeightX = 0
    if onehundredeightY < 0 then onehundredeightY = 0
    onehundredeight$ = map1$(onehundredeightX, onehundredeightY)

    onehundrednineX = PlayerLocX - 5
    onehundrednineY = PlayerLocY + 4
    if onehundrednineX < 0 then onehundrednineX = 0
    if onehundrednineY < 0 then onehundrednineY = 0
    onehundrednine$ = map1$(onehundrednineX, onehundrednineY)

    onehundredtenX = PlayerLocX + 5
    onehundredtenY = PlayerLocY + 4
    if onehundredtenX < 0 then onehundredtenX = 0
    if onehundredtenY < 0 then onehundredtenY = 0
    onehundredten$ = map1$(onehundredtenX, onehundredtenY)

    oneelevenX = PlayerLocX - 5
    oneelevenY = PlayerLocY + 5
    if oneelevenX < 0 then oneelevenX = 0
    if oneelevenY < 0 then oneelevenY = 0
    oneeleven$ = map1$(oneelevenX, oneelevenY)

    onetwelveX = PlayerLocX - 4
    onetwelveY = PlayerLocY + 5
    if onetwelveX < 0 then onetwelveX = 0
    if onetwelveY < 0 then onetwelveY = 0
    onetwelve$ = map1$(onetwelveX, onetwelveY)

    onethirteenX = PlayerLocX - 3
    onethirteenY = PlayerLocY + 5
    if onethirteenX < 0 then onethirteenX = 0
    if onethirteenY < 0 then onethirteenY = 0
    onethirteen$ = map1$(onethirteenX, onethirteenY)

    onefourteenX = PlayerLocX - 2
    onefourteenY = PlayerLocY + 5
    if onefourteenX < 0 then onefourteenX = 0
    if onefourteenY < 0 then onefourteenY = 0
    onefourteen$ = map1$(onefourteenX, onefourteenY)

    onefifteenX = PlayerLocX - 1
    onefifteenY = PlayerLocY + 5
    if onefifteenX < 0 then onefifteenX = 0
    if onefifteenY < 0 then onefifteenY = 0
    onefifteen$ = map1$(onefifteenX, onefifteenY)

    onesixteenX = PlayerLocX
    onesixteenY = PlayerLocY + 5
    if onesixteenY < 0 then onesixteenY = 0
    onesixteen$ = map1$(onesixteenX, onesixteenY)

    oneseventeenX = PlayerLocX + 1
    oneseventeenY = PlayerLocY + 5
    if oneseventeenX < 0 then oneseventeenX = 0
    if oneseventeenY < 0 then oneseventeenY = 0
    oneseventeen$ = map1$(oneseventeenX, oneseventeenY)

    oneeighteenX = PlayerLocX + 2
    oneeighteenY = PlayerLocY + 5
    if oneeighteenX < 0 then oneeighteenX = 0
    if oneeighteenY < 0 then oneeighteenY = 0
    oneeighteen$ = map1$(oneeighteenX, oneeighteenY)

    onenineteenX = PlayerLocX + 3
    onenineteenY = PlayerLocY + 5
    if onenineteenX < 0 then onenineteenX = 0
    if onenineteenY < 0 then onenineteenY = 0
    onenineteen$ = map1$(onenineteenX, onenineteenY)

    onetwentyX = PlayerLocX + 4
    onetwentyY = PlayerLocY + 5
    if onetwentyX < 0 then onetwentyX = 0
    if onetwentyY < 0 then onetwentyY = 0
    onetwenty$ = map1$(onetwentyX, onetwentyY)

    onetwentyoneX = PlayerLocX + 5
    onetwentyoneY = PlayerLocY + 5
    if onetwentyoneX < 0 then onetwentyoneX = 0
    if onetwentyoneY < 0 then onetwentyoneY = 0
    onetwentyone$ = map1$(onetwentyoneX, onetwentyoneY)



'    if one$ = "" then one$ = "#"
'    if two$ = "" then two$ = "#"
'    if three$ = "" then three$ = "#"
'    if four$ = "" then four$ = "#"
'    if six$ = "" then six$ = "#"
'    if seven$ = "" then seven$ = "#"
'    if eight$ = "" then eight$ = "#"
'    if nine$ = "" then nine$ = "#"


    print #main.screen, eightytwo$ + eightythree$ + eightyfour$ + eightyfive$ + eightysix$ + eightyseven$ + eightyeight$ + eightynine$ + ninety$ + ninetyone$ + ninetytwo$
    print #main.screen, ninetythree$ + fifty$ + fiftyone$ + fiftytwo$ + fiftythree$ + fiftyfour$ + fiftyfive$ + fiftysix$ + fiftyseven$ + fiftyeight$ + ninetyfour$
    print #main.screen, ninetyfive$ + fiftynine$ + twentysix$ + twentyseven$ + twentyeight$ + twentynine$ + thirty$ + thirtyone$ + thirtytwo$ + sixty$ + ninetysix$
    print #main.screen, ninetyseven$ + sixtyone$ + thirtythree$ + ten$ + eleven$ + twelve$ + thirteen$ + fourteen$ + thirtyfour$ + sixtytwo$ + ninetyeight$
    print #main.screen, ninetynine$ + sixtythree$ + thirtyfive$ + fifteen$ + one$ + two$ + three$ + sixteen$ + thirtysix$ + sixtyfour$ + onehundred$
    print #main.screen, onehundredone$ + sixtyfive$ + thirtyseven$ + seventeen$ + four$ + "@" + six$ + eighteen$ + thirtyeight$ + sixtysix$ + onehundredtwo$
    print #main.screen, onehundredthree$ + sixtyseven$ + thirtynine$ + nineteen$ + seven$ + eight$ + nine$ + twenty$ + fourty$ + sixtyeight$ + onehundredfour$
    print #main.screen, onehundredfive$ + sixtynine$ + fourtyone$ + twentyone$ + twentytwo$ + twentythree$ + twentyfour$ + twentyfive$ + fourtytwo$ + seventy$ + onehundredsix$
    print #main.screen, onehundredseven$ + seventyone$ + fourtythree$ + fourtyfour$ + fourtyfive$ + fourtysix$ + fourtyseven$ + fourtyeight$ + fourtynine$ + seventytwo$ + onehundredeight$
    print #main.screen, onehundrednine$ + seventythree$ + seventyfour$ + seventyfive$ + seventysix$ + seventyseven$ + seventyeight$ + seventynine$ + eighty$ + eightyone$ + onehundredten$
    print #main.screen, oneeleven$ + onetwelve$ + onethirteen$ + onefourteen$ + onefifteen$ + onesixteen$ + oneseventeen$ + oneeighteen$ + onenineteen$ + onetwenty$ + onetwentyone$

end function

