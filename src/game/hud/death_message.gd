extends Label

func _ready():
	game.connect("death", self, "death")

func death():
	visible = !visible
