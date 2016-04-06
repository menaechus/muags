# Introduction #

This tells you what the .item file holds


# Details #

One piece of data per line
  * Item type (1 = weapon, 2 = armour, 3 = food, 4 = needed for something, 5 = quest, 6 = drink, 7 = trinket, 8 = junk, add more as you think you'll need them)
  * SubClass (1 = one handed sword, 2 = two-handed sword, etc. will define more as needed)
  * Quality (0 - 100, zero being worst)
  * rarity (1 = junk, 2 = common, 3 = magical, 4 = rare, 5 = epic, 6 = godly)
  * Base damage (base damage before stats and luck changes it, 0 - 999999, used only for weapons)
  * Base armour (base armour before stats etc 0 - 999999, used mainly for armours but weapons might have armour too)
  * short desc
  * longer desc
  * slot (1 = main hand, 2 = off hand, 3 = one hand, 4 = head, 5 = upper body, 6 = legs, etc add as needed)
  * inventory icon id (0001 = basic sword icon, add as you need)
  * model id (not used yet)
  * modifier 1 stat (0 = not used, 1 = agi, 2 = str etc)
  * modifier 1 value (0 - 999999)
  * mod 2 stat
  * mod 2 value
  * ItemSpell (/data/items/spells/ hold the item spells)