extends ProgressBar

onready var player = get_tree().get_root().find_node("Player", true, false)#get_node("../../Player")
var exhausted = false #flag to check player exhaustion

func _ready():
	if game.stamina == -1:
		game.stamina = max_value
		value = max_value
	else:
		value = game.stamina

func _process(delta):
	if value == min_value: #if stamina is min player is exhausted
		exhausted = true
	
	if exhausted: #if player is exhausted then he cannot run until stamina has fully recovered
		if value == max_value:
			exhausted = false
			player.current_sprint_speed = game.sprint_speed
		else:
			player.current_sprint_speed = game.walk_speed
	
	if Input.is_action_pressed("sprint") and !exhausted:
		value -= 1
	else:
		value += .5
