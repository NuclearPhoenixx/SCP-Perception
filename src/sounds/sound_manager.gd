extends Node

#delay between steps in ms
const WALK_DELAY = .02
const SPRINT_DELAY = 0

# PLAYER
var walk = []
var sprint = []
var keycard_use = []
# DOORS
var door_open = []
var door_close = []
# DEATH AND DAMAGE
var death_sounds = {}
# SCPs
var shadow_person = []

func _ready():
	walk = load_stream("step/walk/step")
	sprint = load_stream("step/sprint/sprint")
	keycard_use = load_stream("interact/keycard_use", 2)
	door_open = load_stream("facility/door/door_open", 3)
	door_close = load_stream("facility/door/door_close", 3)
	shadow_person = load_stream("scps/017/effect", 3)
	
	load_death_sounds()

func load_stream(dir, m = 8): # !! WARNING: Path not working in export !!
	var file = File.new()
	var array = []
	
	for i in range(1,m+1):
		var path = "res://sounds/" + dir + str(i) + ".ogg"
		if file.file_exists(path):
			array.append(load(path))
	
	return array

func load_death_sounds(): #array name must be the same as scene name!
	death_sounds["SCP-173"] = load_stream("scps/173/neck_snap", 3)
	death_sounds["SCP-017"] = load_stream("scps/017/catch", 1)
