extends Node

onready var player = get_tree().get_root().find_node("Player", true, false)
var inventory = {}

signal update_inventory

func _ready():
	game.connect("death", self, "delete_inventory")

func delete_inventory(): #upon death, delete the whole inventory
	inventory.clear()

func pickup(item):
	if inventory.size() < game.inventory_size:
		var clearance
		for group in item.get_groups():
			if "level" in group:
				clearance = group
			
		inventory[item.name] = [item.filename, clearance] #save item name with path and other info
		item.queue_free()
		emit_signal("update_inventory")
	else:
		print("Inventory is full!")

func drop(name):
	spawn.spawn_keycard(name, player.position)
	inventory.erase(name)
	emit_signal("update_inventory")

func create_item_name(string): #Ugly as hell, no built-in functions for this. Dont need any more item name dicts though.
	var numbers = ["0","1","2","3","4","5","6","7","8","9"] #Firstly remove all numbers
	for n in numbers:
		string = string.replace(n, "")
	
	var i = 0
	var replace_counter = 0
	
	for s in string: #Then add space in front of uppercase char
		if s.to_lower() != s and i != 0:
			string = string.insert(i + replace_counter, " ")
			replace_counter += 1
		i += 1
	
	return string

func get_item_names(): #Grab all the item names in the inventory for viewing in hud
	var names = []
	
	for key in inventory.keys():
		var name = create_item_name(key)
		names.append(name)
		
	return names

func get_item_textures(): #Grab all the item textures in the inventory for viewing in hud
	var textures = []
	
	for value in inventory.values():
		var item = load(value[0]).instance()
		textures.append(item.texture.resource_path)
		item.queue_free()
	
	return textures

func get_clearance_levels():
	var levels = []
	
	for value in inventory.values():
		var c = ""
		
		for i in value: #save highest security clearance
			if "level" in i and int(i) > int(c):
				c = i
			
		levels.append("Security " + c.capitalize())
	
	return levels
