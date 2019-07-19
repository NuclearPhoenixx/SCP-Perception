extends StaticBody2D

onready var door_sprite = get_node("DoorModel")
onready var anim = door_sprite.get_node("DoorAnimation")
onready var door_sound = get_node("DoorSound")
onready var key_sound = get_node("KeycardSound")

var door_clearance = 0 #no clearance needed

func _ready():
	set_process_unhandled_key_input(false)
	get_node("LightOccluderLeft").occluder = get_node("LightOccluderLeft").occluder.duplicate()
	get_node("LightOccluderRight").occluder = get_node("LightOccluderRight").occluder.duplicate()
	
	#query own security level group
	for group in get_groups():
		if "level" in group:
			door_clearance = int(group)
			break
	
	#set right door colors for error animation
	var color = get_node("DoorStatus").color
	var a = [0,1]
	var b = [1,3,5]
	var animation = anim.get_animation("door_error")
	
	for i in a:
		for j in b:
			animation.track_set_key_value(i, j, color)

func check_clearance(): #query clearance level from inventory
	if door_clearance == 0: #check if door is open for everyone
		return true
	
	for clearance in inventory.get_clearance_levels():
		if int(clearance) >= door_clearance:
			key_sound.stream = sound.keycard_use[0] #if adequate play OK sound
			key_sound.play(.4)
			return true
	
	return false

func door_error(): #security clearance not adequate
	anim.play("door_error")

func door_control():
	if !anim.is_playing():
		if !check_clearance(): #check door for adequate clearance
			door_error()
			return
		
		var randint = round(rand_range(0,2))
		
		if door_sprite.frame == 0: #closed
			anim.play_backwards("door_anim")
			door_sound.stream = sound.door_open[randint]
			door_sound.play(.3)
		else: #opened
			anim.play("door_anim")
			door_sound.stream = sound.door_close[randint]
			door_sound.play(0)

func _unhandled_key_input(event):
	if event.is_action_pressed("interact"):
		get_tree().set_input_as_handled()
		door_control()

func _on_InteractionArea_body_entered(body):
	if body.is_in_group("player"):
		set_process_unhandled_key_input(true)

func _on_InteractionArea_body_exited(body):
	if body.is_in_group("player"):
		set_process_unhandled_key_input(false)
