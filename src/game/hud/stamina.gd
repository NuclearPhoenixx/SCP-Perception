extends ProgressBar

func _ready():
	max_value = game.stamina
	value = game.stamina

func _physics_process(delta):
	if value == 0: #if stamina is 0 then the player is exhausted and stops sprinting
		game.player_exhausted = true
	
	#if player is exhausted then he cannot run until stamina has fully recovered
	if game.player_exhausted and value == max_value:
		game.player_exhausted = false
	
	if Input.is_action_pressed("sprint") and !game.player_exhausted:
		value -= 1
	else:
		value += .5
