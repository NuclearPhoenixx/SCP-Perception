extends Node

var standard_keycard = preload("res://scenes/items/keycard1.tscn")
var mp_player = preload("res://scenes/multiplayer/mp_player.tscn")

func spawn_keycard(name, position, rotation): #spawn any keycard
	var card = standard_keycard.instance()
	card.name = name
	card.position = position
	card.rotation = rotation
	get_tree().get_root().get_node("World/Navigation/Map/Items").add_child(card)
	return card

func spawn_mp_player(name, position): #for multiplayer only
	var player = mp_player.instance()
	player.name = name
	player.position = position
	get_tree().get_root().get_node("World").add_child(player)
	return player
