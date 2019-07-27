extends AudioStreamPlayer

onready var the_dread = preload("res://music/menu/the_dread.ogg")

func _ready():
	connect("finished", self, "loop_theme")

func loop_theme():
	stream = the_dread
	play()
