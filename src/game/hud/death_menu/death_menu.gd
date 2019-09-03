extends PanelContainer

func _ready():
	game.connect("player_died", self, "player_died")
	set_process_unhandled_key_input(false)

func player_died(name):
	set_process_unhandled_key_input(true)

func _unhandled_key_input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().set_input_as_handled()
		visible = !visible
