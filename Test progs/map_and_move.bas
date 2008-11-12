mapfilee$ = DefaultDir$ + "\maps\"
mapfile$ = mapfilee$ + "map.1"

dim dummy$(1000)
dim map1$(1000,1000)
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
[printloop]

    for y = 0 to x
    print dummy$(y)
    next y

[dummyTOmap]

xx = 0
yy = 0

    for xx = 0 to x
        for yy = 0 to 1000
        map1$(xx,yy) = mid$(dummy$(xx), yy, 1)

        next yy
    next xx






[end]
end

