    
    open "mypassword.bin" for binary as #mypassword

    print #mypassword, "testPassword"
    
    close #mypassword
    end

    open "myaccount.bin" for binary as #myaccount
    
    print #myaccount, "testAccount"

    close #myaccount
    end

    wait


