extends Control

func _unhandled_key_input(event):
	if event.is_action_pressed("inventory"): #show/hide inventory
		#get_tree().set_input_as_handled()
		visible = !visible
