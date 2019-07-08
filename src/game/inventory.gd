extends Node

var inventory_names = []
var inventory_paths = []

func pickup(item):
	inventory_paths.append(item.filename)
	inventory_names.append(item.name)
	
	item.queue_free()
	print(inventory_names)
	print(inventory_paths)

func drop(item):
	pass
