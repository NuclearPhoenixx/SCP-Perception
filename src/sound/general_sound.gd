extends AudioStreamPlayer

func _ready():
	inventory.connect("item_grabbed", self, "grab_item")
	inventory.connect("item_dropped", self, "drop_item")
	game.connect("player_died", self, "player_death")

func grab_item(): #this sound plays when the player picks up an item
	stream = sound.item_pickup[0]
	play()

func drop_item():
	pass
	#stream = sound.item_drop[round(rand_range(0,))]
	#play()

func player_death(killer_name):
	var array = sound.death_sounds[killer_name]
	stream = array[round(rand_range(0,array.size()-1))]
	play()
