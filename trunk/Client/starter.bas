'Form created with the help of Freeform 3 v03-27-03
'Generated on Feb 24, 2008 at 20:08:20


[setup.starter.Window]

    '-----Begin code for #starter

    nomainwin
    WindowWidth = 350
    WindowHeight = 270
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)


    '-----Begin GUI objects code

    groupbox #starter.groupbox9, "Create an Account",   5, 112, 330, 125
    groupbox #starter.groupbox8, "Start the game",   5,   7, 330, 100
    button #starter.button10,"Start the Game",[Start], UL,  15,  42, 310,  25
    statictext #starter.statictext11, "Account",  15, 132, 105,  20
    statictext #starter.statictext12, "Password",  15, 157,  60,  20
    statictext #starter.statictext14, "Password Again",  15, 182,  98,  20
    TextboxColor$ = "white"
    textbox #starter.account, 185, 127, 135,  25
    textbox #starter.pwd, 185, 152, 135,  25
    textbox #starter.pwdagain, 185, 177, 135,  25
    button #starter.button18,"Create the Account",[accountcreate], UL,  15, 207, 305,  25

    '-----End GUI objects code

    open "MUAGS Starter" for window_nf as #starter
    print #starter, "font ms_sans_serif 10"
    print #starter, "trapclose [quit.starter]"


[starter.inputLoop]   'wait here for input event
    wait



[Start]   'Perform action for the button named 'button10'

    'Insert your own code here

    wait


[accountcreate]   'Perform action for the button named 'button18'

    'Insert your own code here

    wait

[quit.starter] 'End the program
    close #starter
    end

