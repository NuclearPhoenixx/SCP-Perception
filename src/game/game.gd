extends Node

#PLAYER VARIABLES
var stamina = -1 #tracks current stamina, -1 for full stamina on spawn
var stamina_regen = .5 #stamina regeneration rate
var exh_rate = 1 #stamina exhaustion rate
var walk_speed = 60 #normal walking speed
var sprint_speed = 100 #speed for sprinting
var inventory_size = 8 #max number of items in inventory

signal toggle_inventory #signal to open/close the inventory, triggered by player
signal death #signal that the player has died

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	connect("death", self, "death")

func death():
	print("You died!")
	get_tree().reload_current_scene()

func _unhandled_key_input(event):
	if event.is_action_pressed("ui_cancel"): #quit game
		get_tree().quit()
	
	if event.is_action_pressed("reset"): #reset scene
		get_tree().reload_current_scene()
	
	if event.is_action_pressed("debug"): #enable debugging mode
		settings.emit_signal("debug_mode")
		get_tree().set_input_as_handled()
	
	if event.is_action_pressed("inventory"): #show/hide inventory
		emit_signal("toggle_inventory")
		get_tree().set_input_as_handled()
