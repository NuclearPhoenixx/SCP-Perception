extends PanelContainer

func _unhandled_key_input(event):
	if event.is_action_pressed("ui_cancel"):
		visible = !visible
		var tree = get_tree()
		tree.paused = !tree.paused