extends Area2D

func _on_DeathZone_body_entered(body): #collision with any enemy will kill you
	if body.is_in_group("lethal") and !settings.debug_mode:
		print("You died!")
		get_tree().reload_current_scene()
