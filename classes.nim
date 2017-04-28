# The types used in Classes
type
  # Types for the player
  Pos     = tuple[x: int, y: int]
  Stats   = tuple[hp: int, ap: int]
  Class   = tuple[name: string, atk: int, def: int, mov: int, mag: int]

# All available classes
const
  classes: seq[Class] = @[
    (name: "Viking",      atk: 5, def: 2, mov: 2, mag: 1),
    (name: "Juggernaut",  atk: 4, def: 4, mov: 1, mag: 0),
    (name: "Battle Mage", atk: 2, def: 3, mov: 2, mag: 4),
    (name: "Rogue",       atk: 3, def: 1, mov: 4, mag: 2),
    (name: "Marauder",    atk: 3, def: 3, mov: 3, mag: 2)
  ]