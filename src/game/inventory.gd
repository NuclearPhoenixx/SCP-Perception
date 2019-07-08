extends Node

var inventory = {}
var INVENTORY_SIZE = 8 #max number of items in inventory

func pickup(item):
	if inventory.size() < INVENTORY_SIZE:
		inventory[item.name] = item.filename
		item.queue_free()
	else:
		print("Inventory is full!")
	
	print(get_item_names()) #debug

func drop(item):
	pass

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
