# Introduction #

this is the list of the authcodes used in the MUAGS

**00000 is used for version checking (like: "00000 1.0")**

**00001 is used for account creation (like: "00001 account passwd")**

**00002 is used for logging in (Like: "00002 account passwd")**

**00003 is used for telling the client that user is not logged in (Like: "00003")**

**00004 is used for gamenews (client send only 00004 and server responds with 00004 followed by gamenews)**

**00005 is used for character list (client sends 00005 and server responds with a list of clients characters)**

**00006 is used by the server to send the character list**

**00007 is used to get character info (like: "00007 characternumber" and the server responds with "00007 charactername class race gender level xcoord ycoord zcoord" etc.)**

**00010 is used to create a character (client sends: "00010 char\_name char\_race" server then checks name and fills the rest and returns "00010 ok" or "00010 error num" where num is 1 for name taken etc..)**

**00100 is used for /chat (Like "00100 fromplayer msg")**

**00200 is used for movement (Like "00200 direction")**

**00201 is used to query player coordinates (Like "00201" and the server responds with "00201 x y"**

**01000 is used for /tell (Like: "01000 fromplayer toplayer msg")**

**90000 to 99999 is reserved for helper/coder/admin commands**

**90001 is user for to get user info based on character name**

**90002 is used for changing account level**
