mapfilee$ = DefaultDir$ + "\maps\"
mapfile$ = mapfilee$ + "map.1"

'dim PlayerLoc(5,5)
global PlayerLocX
global PlayerLocY
global cmd
dim dummy$(1000)
dim map1$(1000,1000)
PlayerLocX = 30
PlayerLocY = 30
x = 0
open mapfile$ for input as #1
[loop]

    input #1, dummy$(x)
    x = x + 1
    if eof(#1) = 0 then [loop]
close #1
x = x - 1
y = 0

'This is here just so you can print the map from the dummy and see if it works
'[printloop]
'
'    for y = 0 to x
'    print dummy$(y)
'    next y

[dummyTOmap]

xx = 0
yy = 0

    for xx = 0 to x
        for yy = 0 to 1000
        map1$(yy,xx) = mid$(dummy$(xx), yy, 1)
        'if map1$(xx,yy) = "" then yy = 1000
        next yy
    next xx
rc = drawMap(PlayerLocX, PlayerLocY)
[MoveTest]
print PlayerLocX; " : "; PlayerLocY
input command$

if command$ = "quit" then
        goto [end]
else
        call CheckCmd command$
end if

if cmd <> 0 then a = MovePlayer(cmd)

[DrawTest]
cls
rc = drawMap(PlayerLocX, PlayerLocY)




goto [MoveTest]

[end]
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

'    if one$ = "" then one$ = "#"
'    if two$ = "" then two$ = "#"
'    if three$ = "" then three$ = "#"
'    if four$ = "" then four$ = "#"
'    if six$ = "" then six$ = "#"
'    if seven$ = "" then seven$ = "#"
'    if eight$ = "" then eight$ = "#"
'    if nine$ = "" then nine$ = "#"


    print twentysix$ + twentyseven$ + twentyeight$ + twentynine$ + thirty$ + thirtyone$ + thirtytwo$
    print thirtythree$ + ten$ + eleven$ + twelve$ + thirteen$ + fourteen$ + thirtyfour$
    print thirtyfive$ + fifteen$ + one$ + two$ + three$ + sixteen$ + thirtysix$
    print thirtyseven$ + seventeen$ + four$ + "@" + six$ + eighteen$ + thirtyeight$
    print thirtynine$ + nineteen$ + seven$ + eight$ + nine$ + twenty$ + fourty$
    print fourtyone$ + twentyone$ + twentytwo$ + twentythree$ + twentyfour$ + twentyfive$ + fourtytwo$
    print fourtythree$ + fourtyfour$ + fourtyfive$ + fourtysix$ + fourtyseven$ + fourtyeight$ + fourtynine$

end function


