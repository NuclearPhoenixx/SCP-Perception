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

signal player_died #signal launched when player dies
signal loading_started #signal launched when loading a new map has started
signal loading_ended #signal launched when loading a new map has ended

var player_data # THIS HOLDS ALL PLAYER DATA

func _init():
	pause_mode = Node.PAUSE_MODE_PROCESS
	init_player_data()

func init_player_data(): #STANDARD VALUES FOR PLAYER DATA
	player_data = {"exhausted": false,
					"stamina": STAMINA,
					"blinking": false,
					"blink": BLINK
					}

func _unhandled_key_input(event):
	if event.is_action_pressed("ui_cancel"): #quit game
		#var packed_scene = PackedScene.new()
		#packed_scene.pack(get_tree().get_current_scene())
		#ResourceSaver.save("res://the_scene.tscn", packed_scene)
		# This saves the whole scene in the correct format. Saves all nodes, call set_owner() prior
		get_tree().quit()
	
	if event.is_action_pressed("reset"): #reset scene
		get_tree().set_input_as_handled()
		get_tree().paused = false
		
		#load_map(get_tree().get_root().get_node("Main/World").filename)
		reset_map()

func load_map(map_path): #this will load a new map, leaving all player stats and hud untouched
	emit_signal("loading_started")
	get_node("/root/Main/World").free() #free old map completely
	
	var NewMap = load(map_path).instance() #load and instance new map
	get_node("/root/Main").add_child(NewMap)
	emit_signal("loading_ended")

func reset_map(): #this will reload the current map, resetting all player stats and hud
	get_tree().reload_current_scene()
	init_player_data()
	inventory.inventory.clear()
