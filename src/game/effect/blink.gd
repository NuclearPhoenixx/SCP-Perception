extends ProgressBar

onready var BlinkTimer = get_node("BlinkTime")

var BlinkNode

func _ready():
	max_value = game.BLINK
	value = game.player_data["blink"]
	BlinkTimer.wait_time = game.BLINK_TIME
	game.connect("loading_started", self, "save_data")
	#spawn blink rect from software -> self contained
	BlinkNode = ColorRect.new()
	BlinkNode.anchor_bottom = 1
	BlinkNode.anchor_right = 1
	BlinkNode.size_flags_horizontal = SIZE_FILL
	BlinkNode.size_flags_vertical = SIZE_FILL
	BlinkNode.color = Color.black
	BlinkNode.hide()
	get_parent().call_deferred("add_child_below_node", self, BlinkNode)

func save_data():
	game.player_data["blink"] = value

func _physics_process(delta):
	if value == 0 and BlinkTimer.is_stopped():
		blink_once()
	else:
		value -= game.BLINK_RATE

func _unhandled_key_input(event):
	if event.is_action_pressed("blink"): #if player started blinking
		get_tree().set_input_as_handled()
		BlinkNode.show()
		game.player_data["blinking"] = true
	elif event.is_action_released("blink"): #if player stopped blinking
		get_tree().set_input_as_handled()
		BlinkTimer.start()

func blink_once():
	BlinkNode.show()
	game.player_data["blinking"] = true
	BlinkTimer.start()

func _on_BlinkTime_timeout():
	BlinkNode.hide()
	game.player_data["blinking"] = false
	value = max_value
