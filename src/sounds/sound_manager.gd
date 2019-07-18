extends Node

#delay between steps in ms
const WALK_DELAY = .02#20
const SPRINT_DELAY = 0
const WBACK_DELAY = .1

# SOUND FILE ARRAYS
var walk = []
var sprint = []

func _ready():
	load_stream("step/walk/step", walk)
	load_stream("step/sprint/sprint", sprint)

func load_stream(dir, array): # !! WARNING: Path not working in export !!
	var file = File.new()
	for i in range(1,8):
		var path = "res://sounds/" + dir + str(i) + ".ogg"
		if file.file_exists(path):
			array.append(load(path))
