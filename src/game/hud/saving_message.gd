extends PanelContainer

onready var timer = get_node("Timer")

func _ready():
	game.connect("saving_started", self, "saving")
	game.connect("saving_finished", self, "launch_timer")

func saving():
	visible = true

func launch_timer():
	timer.start()

func _on_Timer_timeout():
	visible = false
