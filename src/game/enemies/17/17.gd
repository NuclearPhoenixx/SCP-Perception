extends KinematicBody2D

onready var nav = get_tree().get_root().find_node("Navigation", true, false)#get_node("../Navigation")
#onready var player = get_tree().get_root().find_node("Player", true, false)#get_node("../Player")
onready var pathfinding = get_node("DebugPathfinding")

var SPEED = 80
var target = null
var path = PoolVector2Array()

func move(distance):
	var direction = distance.normalized()
	move_and_slide(direction * SPEED)

func dynamic_move():
	path = nav.get_simple_path(position, target.position)
	var distance = path[1] - position
	
	if distance.length() == 0:
		path.remove(1)
		return
	
	move(distance)
	look_at(target.position)

func finish_move():
	var distance = path[0] - position
	
	if distance.length() <= 2:
		path.remove(0)
	
	move(distance)

func open_door(door): #this function will probably kill everybody
	if !door.open:
		door.door_control()
		print("FBI open up!")

func _physics_process(delta):
	if typeof(target) != 0: #if target node present follow it
		dynamic_move()
	elif path.size() != 0: #if no target node, dont create new path and finish walking path
		finish_move()
	
	for i in get_slide_count(): #if collision with door - open it
		var collision = get_slide_collision(i).collider
		if collision.is_in_group("doors"):
			open_door(collision)
	
	# DEBUG STUFF
	if settings.debug_mode: #if in debug mode then show the pathfinding vectors
		var debug_path = PoolVector2Array()
		for i in path:
			debug_path.append(to_local(i))
		pathfinding.points = debug_path
