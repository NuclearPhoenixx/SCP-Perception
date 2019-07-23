extends ColorRect

func _ready():
	game.connect("player_died", self, "death")

func death():
	visible = !visible