extends Node

#SETTINGS
var debug_mode = false
var zoom_res = .05 #resolution of a single camera zoom. makes it faster or slower

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS

func _unhandled_key_input(event):
	if event.is_action_pressed("debug"): #enable debugging mode
		get_tree().set_input_as_handled()
		debug_mode = !debug_mode
