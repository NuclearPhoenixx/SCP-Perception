extends "res://src/game/item/item_pickup.gd"

export(String, MULTILINE) var item_name = "Level 1 Keycard"
export(String, MULTILINE) var item_description = "A Level 1 security keycard. Can be used to open security doors."
export(bool) var has_clearance = true
export(int, 10) var item_clearance = 1

func save():
	var dict = {
				"item_dict": {
							"item_name": item_name,
							"item_description": item_description,
							"has_clearance": has_clearance,
							"item_clearance": item_clearance
							}
				}
	return dict
