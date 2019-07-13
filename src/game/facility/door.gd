extends StaticBody2D

onready var door_sprite = get_node("DoorModel")
onready var anim = door_sprite.get_node("DoorAnimation")

var door_clearance = "none" #no clearance needed

func _ready():
	set_process_unhandled_key_input(false)
	get_node("LightOccluderLeft").occluder = get_node("LightOccluderLeft").occluder.duplicate()
	get_node("LightOccluderRight").occluder = get_node("LightOccluderRight").occluder.duplicate()
	
	for group in get_groups(): #query own security level group
		if "level" in group:
			door_clearance = group
			break

func check_clearance(): #spawn item, query clearance level and clean up
	if door_clearance == "none": #check if door is open for everyone
		return true
	
	var inv_clearances = []
	
	for value in inventory.inventory.values():
		var item = load(value).instance()
		
		for group in item.get_groups():
			inv_clearances.append(group)
		
		item.queue_free()
	
	for c in inv_clearances:
		if c == door_clearance:
			return true
	
	return false

func door_error():
	var color = get_node("DoorStatus").color
	var a = [0,1]
	var b = [1,3,5]
	var animation = anim.get_animation("door_error")
	
	for i in a:
		for j in b:
			animation.track_set_key_value(i, j, color)
	
	anim.play("door_error")

func door_control():
	if !anim.is_playing():
		if !check_clearance(): #check door for adequate clearance
			door_error()
			return
		
		if door_sprite.frame == 0: #closed
			anim.play_backwards("door_anim")
		else: #open
			anim.play("door_anim")

func _unhandled_key_input(event):
	if event.is_action_pressed("interact"):
		get_tree().set_input_as_handled()
		door_control()

func _on_InteractionArea_body_entered(body):
	if "Player" in body.name:
		set_process_unhandled_key_input(true)

func _on_InteractionArea_body_exited(body):
	set_process_unhandled_key_input(false)
