extends ProgressBar

var player_exhausted = false #true if the player is too exhausted to be sprinting

func _ready():
	max_value = game.STAMINA
	value = game.STAMINA

func _physics_process(delta):
	if value == 0: #if stamina is 0 then the player is exhausted and stops sprinting
		player_exhausted = true
	
	#if player is exhausted then he cannot run until stamina has fully recovered
	if player_exhausted and value == max_value:
		player_exhausted = false
	
	if Input.is_action_pressed("sprint") and !player_exhausted:
		value -= game.STAMINA_EXHAUST
	else:
		value += game.STAMINA_REGEN
