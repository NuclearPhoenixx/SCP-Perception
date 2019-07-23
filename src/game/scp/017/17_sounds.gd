extends AudioStreamPlayer2D

func _on_Timer_timeout(): #play random 017 sound every timeout seconds
	stream = sound.shadow_person[round(rand_range(0,2))]
	play(rand_range(10,20)) #play next sound in random interval
