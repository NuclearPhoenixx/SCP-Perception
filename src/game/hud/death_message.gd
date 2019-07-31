extends ColorRect

func _ready():
	game.connect("player_died", self, "death")
	game.connect("loading_finished", self, "hide")

func death(killer_name):
	get_node("MessageText").text %= killer_name
	visible = !visible
