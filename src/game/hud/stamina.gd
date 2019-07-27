extends TextureProgress

func _ready():
	max_value = game.STAMINA #load and set all the player values
	value = game.player_data["stamina"]
	game.connect("loading_started", self, "save_data")

func save_data():
	game.player_data["stamina"] = value

func _physics_process(delta):
	if value == 0: #if stamina is 0 then the player is exhausted and stops sprinting
		game.player_data["exhausted"] = true
	
	#if player is exhausted then he cannot run until stamina has fully recovered
	if game.player_data["exhausted"] and value == max_value:
		game.player_data["exhausted"] = false
	
	if Input.is_action_pressed("sprint") and !game.player_data["exhausted"]:
		value -= game.STAMINA_EXHAUST
	else:
		value += game.STAMINA_REGEN
