extends Node

var inventory = {} #PLAYER INVENTORY

signal item_dropped #optional: just update the inventory change instead of everything?
signal item_grabbed #in regard of performance pretty unimportant though

# ITEM STATS THAT <NEED> TO BE DEFINED FOR THIS TO WORK:
# -> bool has_clearance
# -> String item_name
# -> string item_description

func pickup(item):
	if inventory.size() < game.INVENTORY_SIZE:
		var clearance = -1
		if item.has_clearance:
			clearance = item.clearance
			
		inventory[item.name] = {} #save item name with path and other info
		inventory[item.name]["item_name"] = item.item_name
		inventory[item.name]["item_description"] = item.description
		inventory[item.name]["item_clearance"] = clearance
		inventory[item.name]["filename"] = item.filename
		inventory[item.name]["path"] = item.get_parent().get_path()
		inventory[item.name]["texture"] = item.texture.resource_path
		
		item.queue_free()
		emit_signal("item_grabbed")
		#print("Grab: ", item.name)
		print(inventory.keys())
	else:
		print("Inventory is full!")

func drop(name):
	for player in get_tree().get_nodes_in_group("player"): #drop item at every "player" node
		var item = spawn.spawn_item(inventory[name]["filename"], inventory[name]["path"], name, player.position, player.rotation - PI/2)
		item.item_name = inventory[name]["item_name"]##
		item.description = inventory[name]["item_description"]##
		inventory.erase(name)
		emit_signal("item_dropped")
