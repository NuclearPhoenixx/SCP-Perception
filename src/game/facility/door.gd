extends StaticBody2D

onready var door_sprite = get_node("DoorModel")
onready var anim = door_sprite.get_node("DoorAnimation")

func _ready():
	set_process_unhandled_key_input(false)
	get_node("LightOccluderLeft").occluder = get_node("LightOccluderLeft").occluder.duplicate()
	get_node("LightOccluderRight").occluder = get_node("LightOccluderRight").occluder.duplicate()

func door_control():
	if !anim.is_playing():
		if door_sprite.frame == 0: #closed
			anim.play_backwards("door_anim")
		else: #open
			anim.play("door_anim")

func _unhandled_key_input(event):
	if event.is_action_pressed("interact"):
		door_control()
		get_tree().set_input_as_handled()

func _on_InteractionArea_body_entered(body):
	if "Player" in body.name:
		set_process_unhandled_key_input(true)

func _on_InteractionArea_body_exited(body):
	set_process_unhandled_key_input(false)
