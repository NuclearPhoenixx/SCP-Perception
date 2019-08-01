extends AudioStreamPlayer

onready var the_dread = preload("res://music/menu/the_dread.ogg")

func loop_theme():
	stream = the_dread
	play()
