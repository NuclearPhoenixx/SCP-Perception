extends ProgressBar

onready var blink_node = get_node("../BlinkEffect")
onready var timeout = get_node("BlinkTime")

var player_blink = false

func _ready():
	timeout.wait_time = game.BLINK_TIME

func blink_once():
	blink_node.show()
	player_blink = true
	timeout.start()

func _physics_process(delta):
	if value == 0 and timeout.is_stopped():
		blink_once()
	else:
		value -= game.BLINK_RATE

func _unhandled_key_input(event):
	if event.is_action_pressed("blink"): #if player started blinking
		get_tree().set_input_as_handled()
		blink_node.show()
		player_blink = true
	elif event.is_action_released("blink"): #if player stopped blinking
		get_tree().set_input_as_handled()
		timeout.start()

func _on_BlinkTime_timeout():
	blink_node.hide()
	player_blink = false
	value = max_value
