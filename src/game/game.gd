extends Node

#PLAYER VARIABLES
const STAMINA = 150 #maximum player stamina level
const STAMINA_REGEN = .6 #stamina regeneration rate
const STAMINA_EXHAUST = 1 #stamina exhaustion rate
const WALK_SPEED = 60 #normal walking speed
const WALK_BACK_FACTOR = .5 #speed when walking backwards
const WALK_BACK_ANGLE = 2*PI/3 #angle at which the backwards walking buff takes action
const SPRINT_SPEED = 100 #speed for sprinting
const INVENTORY_SIZE = 8 #max number of items in inventory
const BLINK_RATE = .2 #this affects the time it takes for the player to blink
const BLINK_TIME = .15 #player has eyes closed for this amount of time when blinking

func death():
	print("You died!")
	inventory.inventory.clear() #delete inventory
	get_tree().reload_current_scene()

func _unhandled_key_input(event):
	if event.is_action_pressed("ui_cancel"): #quit game
		get_tree().quit()
	
	if event.is_action_pressed("reset"): #reset scene
		get_tree().set_input_as_handled()
		get_tree().reload_current_scene()
