extends ColorRect

func _ready():
	game.connect("saving_started", self, "saving")
	game.connect("saving_finished", self, "saving")

func saving():
	visible = !visible
