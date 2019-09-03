extends Button

func _on_QuitButton_pressed():
	get_tree().change_scene("res://scenes/main_menu.tscn")
	get_tree().paused = false
