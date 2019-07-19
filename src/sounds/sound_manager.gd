extends Node

#delay between steps in ms
const WALK_DELAY = .02#20
const SPRINT_DELAY = 0
#const WBACK_DELAY = .1

# SOUND FILE ARRAYS
var walk = []
var sprint = []
var keycard_use = []
var door_open = []
var door_close = []

func _ready():
	load_stream("step/walk/step", walk)
	load_stream("step/sprint/sprint", sprint)
	load_stream("interact/keycard_use", keycard_use, 2)
	load_stream("facility/door/door_open", door_open, 3)
	load_stream("facility/door/door_close", door_close, 3)

func load_stream(dir, array, m = 8): # !! WARNING: Path not working in export !!
	var file = File.new()
	for i in range(1,m+1):
		var path = "res://sounds/" + dir + str(i) + ".ogg"
		if file.file_exists(path):
			array.append(load(path))
