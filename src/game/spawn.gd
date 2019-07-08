extends Node

var standard_keycard = preload("res://scenes/items/keycard1.tscn")

func spawn_keycard(name, position):
	var card = standard_keycard.instance()
	card.name = name
	card.position = position
	get_tree().get_root().get_node("World/Navigation/Map/Items").add_child(card)
