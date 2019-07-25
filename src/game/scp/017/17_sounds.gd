extends AudioStreamPlayer2D

func _on_Timer_timeout(): #play random 017 sound every timeout seconds
	stream = sound.shadow_person[core.rand_int(0,2)]
	play(core.rand_float(10,20)) #play next sound in random interval
