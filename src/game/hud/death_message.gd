extends ColorRect

func _ready():
	game.connect("player_died", self, "death")

func death(killer_name):
	get_node("MessageText").text %= killer_name
	visible = !visible