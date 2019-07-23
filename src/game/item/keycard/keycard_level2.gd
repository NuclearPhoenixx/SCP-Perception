extends "res://src/game/item/item_pickup.gd"

export(String, MULTILINE) var item_name = "Level 2 Keycard"
export(String, MULTILINE) var description = "A Level 2 security keycard. Can be used to open security doors."
export(bool) var has_clearance = true
export(int, 10) var clearance = 2
