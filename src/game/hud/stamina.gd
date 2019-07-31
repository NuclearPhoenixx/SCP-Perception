extends TextureProgress


func _ready():
	game.connect("saving_started", self, "save_data")
	game.connect("loading_finished", self, "update_data")
	
	update_data()

func save_data():
	game.player_data["stamina"] = value

func update_data(max_v = game.STAMINA, cur_v = game.player_data["stamina"]):
	max_value = max_v
	value = cur_v

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
