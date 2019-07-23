extends AudioStreamPlayer

func _ready():
	inventory.connect("item_grabbed", self, "grab_item")

func grab_item():
	stream = sound.item_pickup[0]
	play()
