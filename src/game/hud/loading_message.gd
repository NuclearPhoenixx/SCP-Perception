extends ColorRect

func _ready():
	game.connect("loading_started", self, "loading")
	game.connect("loading_finished", self, "loading")

func loading():
	visible = !visible
