# Introduction #

reserved numbers on the server


char 1 = current char, will load these once character is selected

# Details #
  * x = player socket
  * player$(x, 0) = account name
  * player$(x, 1) = account level
  * player$(x, 2) = version ok (1/0)
  * player$(x, 3) = login ok (1/0)
  * player$(x, 200) = char 1 race
  * player$(x, 201) = char 1 gender
  * player$(x, 202) = char 1 name
  * player$(x, 203) = char 1 level
  * player$(x, 204) = char 1 exp

  * player$(x, 210) = char 1 mapID
  * player$(x, 211) = char 1 x coord
  * player$(x, 212) = char 1 y coord
  * player$(x, 213) = char 1 z coord (not used yet)