extends Area2D

func _on_DeathBox_body_entered(body):
	if body.is_in_group("player") and !settings.debug_mode:
		game.emit_signal("death")