extends Node

#PLAYER VARIABLES
var stamina = -1 #tracks current stamina, -1 for full stamina on spawn
var stamina_regen = .5 #stamina regeneration rate
var exh_rate = 1 #stamina exhaustion rate
var walk_speed = 60 #normal walking speed
var sprint_speed = 100 #speed for sprinting

func _init():
	pause_mode = Node.PAUSE_MODE_PROCESS

func _unhandled_key_input(event):
	if event.is_action_pressed("ui_cancel"): #quit game
		get_tree().quit()
	
	if event.is_action_pressed("reset"): #reset scene
		get_tree().reload_current_scene()
	
	if event.is_action_pressed("debug"): #enable debugging mode
		if settings.debug_mode:
			settings.debug_mode = false
		else:
			settings.debug_mode = true
