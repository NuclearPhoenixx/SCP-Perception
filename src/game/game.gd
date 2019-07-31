extends Node

#PLAYER VARIABLES
const STAMINA = 150 #maximum player stamina level
const STAMINA_REGEN = .6 #stamina regeneration rate
const STAMINA_EXHAUST = 1 #stamina exhaustion rate
const WALK_SPEED = 50 #normal walking speed
const WALK_BACK_FACTOR = .5 #speed when walking backwards
const WALK_BACK_ANGLE = 2*PI/3 #angle at which the backwards walking buff takes action
const SPRINT_SPEED = 100 #speed for sprinting
const INVENTORY_SIZE = 8 #max number of items in inventory
const BLINK_RATE = .2 #this affects the time it takes for the player to blink
const BLINK_TIME = .15 #player has eyes closed for this amount of time when blinking
const BLINK = 100 #maximum player blink level

# warning-ignore:unused_signal
signal player_died #signal launched when player dies
signal loading_started #signal launched when loading a new map has started
signal loading_finished #signal launched when loading a new map has ended
signal saving_started #emitted when saving data has started

var player_data # THIS HOLDS ALL PLAYER DATA

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	init_player_data()

func init_player_data(): #STANDARD VALUES FOR PLAYER DATA
	player_data = {
					"exhausted": false,
					"stamina": STAMINA,
					"blinking": false,
					"blink": BLINK
					}

func _unhandled_key_input(event):
	if event.is_action_pressed("ui_cancel"): #quit game
		get_tree().quit()
	
	if event.is_action_pressed("reset"): #reset scene
		get_tree().set_input_as_handled()
		get_tree().paused = false
		
		reset_map()
		
	if event.is_action_pressed("quick_save"):
		save_game("user://quicksave.save")
	
	if event.is_action_pressed("quick_load"):
		load_game("user://quicksave.save")

"""
func load_map(map_path): #this will load a new map, leaving all player stats and hud untouched
	emit_signal("loading_started")
	get_node("/root/Main/World").free() #free old map completely
	
	var NewMap = load(map_path).instance() #load and instance new map
	get_node("/root/Main").add_child(NewMap)
	emit_signal("loading_ended")
	# PAUSE ALL NODES AND UN-PAUSE SO THAT PLAYER IS E.G. NOT ABLE TO BLINK IN LOADING SCREENS
"""

func reset_map(): #this will reload the current map, resetting all player stats and hud
	get_tree().reload_current_scene()
	init_player_data()
	inventory.inventory.clear()

func save_game(path):
	emit_signal("saving_started") #let the game know that we want to save data
	
	var save_game = File.new()
	save_game.open(path, File.WRITE)
	
	save_game.store_line(to_json({"inventory": inventory.inventory})) #save global data
	save_game.store_line(to_json({"player_data": player_data}))
	save_game.store_line(to_json({"map": get_tree().get_root().get_node("Main/World").filename}))
	
	for node in get_tree().get_nodes_in_group("Save"): #save node specific data
		var data
		
		if node.has_method("save"):
			data = node.save()
		else:
			data = {}
		
		data["name"] = node.name
		data["filename"] = node.filename
		data["parent"] = node.get_parent().get_path()
		data["pos_x"] = node.position.x
		data["pos_y"] = node.position.y
		data["rotation"] = node.rotation
		data["scale_x"] = node.scale.x
		data["scale_y"] = node.scale.y
		
		save_game.store_line(to_json(data))
	
	save_game.close()
	
	print("Saving complete.")

func load_game(path):
	var save_game = File.new()
	
	if !save_game.file_exists(path):
		return
	
	emit_signal("loading_started")
	get_tree().paused = true
	
	save_game.open(path, File.READ)
	while !save_game.eof_reached():
		var line = parse_json(save_game.get_line())
		
		if typeof(line) != TYPE_DICTIONARY:
			continue
		
		if line.has("map"):
			var root = get_tree().get_root()
			
			if root.get_node("Main/World").filename != line["map"]: #if not the right map, kill current map and load new map
				root.get_node("Main/World").free()
				var new_map = load(line["map"]).instance()
				root.get_node("Main").add_child_below_node(root.get_node("Main/CanvasMod"), new_map)
			
			for node in get_tree().get_nodes_in_group("Save"):
				node.free()
		
		elif line.has("inventory"):
			inventory.inventory = line["inventory"]
		elif line.has("player_data"):
			player_data = line["player_data"]
		else:
			var node = load(line["filename"]).instance()
			get_node(line["parent"]).add_child(node)
			node.position = Vector2(line["pos_x"], line["pos_y"])
			node.scale = Vector2(line["scale_x"], line["scale_y"])
			
			for i in line.keys():
				if i == "filename" or i == "parent" or i == "pos_x" or i == "pos_y" or i == "scale_x" or i == "scale_y":
					continue
				node.set(i, line[i])
	
	save_game.close()
	
	get_tree().paused = false
	emit_signal("loading_finished")
	print("Loading complete.")
