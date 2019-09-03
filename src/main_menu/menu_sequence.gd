extends TextureRect

onready var stimer = get_node("StaticTimer")
onready var btimer = get_node("BeepTimer")
onready var rect = get_node("../TestImage")
onready var logo = get_node("../FoundationLogo")
onready var dmg_logo = get_node("../FoundationLogoDamaged")

func _ready():
	set_process(false)

func _process(delta):
	texture.width = OS.get_real_window_size().x
	texture.height = OS.get_real_window_size().y
	texture.noise.seed += 1

func _on_WaitTimer_timeout():
	show()
	set_process(true)
	stimer.start()

func _on_StaticTimer_timeout():
	set_process(false)
	hide()
	btimer.start()
	rect.show()

func _on_BeepTimer_timeout():
	rect.hide()
	logo.hide()
	dmg_logo.show()
