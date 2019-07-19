extends Area2D

func _on_KillArea_body_entered(body):
	if body.is_in_group("player") and !settings.debug_mode: #if in debug node, dont kill player
		var sp = body.get_node("PlayerSound")
		var array = sound.death_sounds[get_parent().name]
		sp.stream = array[round(rand_range(0,array.size()-1))]
		sp.play()
		sp.pause_mode = Node.PAUSE_MODE_PROCESS #play death sound
		
		inventory.inventory.clear() #delete inventory
		
		get_tree().paused = true
		
		game.emit_signal("death")
