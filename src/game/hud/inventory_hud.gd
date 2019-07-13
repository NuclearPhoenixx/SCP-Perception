extends Control

onready var slots = get_node("InventorySlots")

func _ready():
	game.connect("toggle_inventory", self, "toggle_inventory")
	inventory.connect("update_inventory", self, "update_inventory")

func toggle_inventory():
	if visible:
		set_process_unhandled_key_input(false)
		hide()
	else:
		set_process_unhandled_key_input(true)
		show()

func update_inventory(): #this function essentially draws the whole inventory items and stuff
	var names = inventory.get_item_names() #get all item names
	var textures = inventory.get_item_textures() #get all item textures
	var clearances = inventory.get_clearance_levels() #get all the security levels for any item
	
	var size = names.size()
	
	for slot in slots.get_children():
		var index = slot.get_index()
		if index < size: #only do this for picked up number of items
			slot.item_name = names[index]
			slot.item_clearance = clearances[index]
			slot.image.texture = load(textures[index])
		else:
			slot.item_name = ""
			slot.item_clearance = ""
			slot.image.texture = null
