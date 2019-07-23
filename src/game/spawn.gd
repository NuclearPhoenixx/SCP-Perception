extends Node

#const StandardKeycard = preload("res://scenes/item/keycard/keycard_level1.tscn")
const MPPlayer = preload("res://scenes/multiplayer/mp_player.tscn") #memory optimization: dont pre-load?

func spawn_item(path, parent, position, rotation=0): #spawn any item
	var item = spawn_node(path, get_node(parent))
	item.position = position
	item.rotation = rotation
	return item

func spawn_mp_player(name, position): #for multiplayer only
	var player = MPPlayer.instance()
	player.name = name
	player.position = position
	get_tree().get_root().get_node("Main/World").add_child(player)
	return player

func spawn_node(filepath, parent): #spawn just a generic node
	var node = load(filepath).instance()
	parent.add_child(node)
	return node
