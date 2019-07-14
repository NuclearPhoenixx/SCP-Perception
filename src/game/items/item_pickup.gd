extends Sprite

func _ready():
	set_process_unhandled_key_input(false)

func _on_PickUpRange_body_entered(body):
	if body.is_in_group("player"):
		set_process_unhandled_key_input(true)

func _on_PickUpRange_body_exited(body):
	if body.is_in_group("player"):
		set_process_unhandled_key_input(false)

func _unhandled_key_input(event):
	if event.is_action_pressed("interact"):
		get_tree().set_input_as_handled()
		inventory.pickup(self)
