extends Control

onready var slots = get_node("InventorySlots")

func _ready():
	inventory.connect("update_inventory", self, "update_inventory")

func toggle_inventory():
	if visible:
		hide()
	else:
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
			slot.get_node("ItemImage").texture = load(textures[index])
		else:
			slot.item_name = ""
			slot.item_clearance = ""
			slot.get_node("ItemImage").texture = null

func _unhandled_key_input(event):
	if event.is_action_pressed("inventory"): #show/hide inventory
		get_tree().set_input_as_handled()
		toggle_inventory()
