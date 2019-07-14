extends KinematicBody2D

onready var nav = get_tree().get_root().find_node("Navigation", true, false)
onready var pathfinding = get_node("DebugPathfinding")
onready var idle_timer = get_node("IdleTimer")

var MOVE_SPEED = 90
var IDLE_SPEED = 40
var IDLE_DISTANCE = 120

var target = null
var path = PoolVector2Array()
var speed

func move(distance):
	var direction = distance.normalized()
	move_and_slide(direction * speed)

func dynamic_move():
	path = nav.get_simple_path(position, target.position)
	var distance = path[1] - position
	
	while distance.length() == 0:
		path.remove(1)
		if path.size() <= 1:
			return
		distance = path[1] - position
	
	look_at(target.position)
	move(distance)

func finish_move():
	var distance = path[0] - position
	
	while distance.length() <= 2: #loop through until valid target pos has been found
		path.remove(0)
		if path.size() == 0:
			return
		distance = path[0] - position
	
	move(distance)

func open_door(door): #this function will probably kill everybody
	door.door_control()
	print("FBI, open up!") #

func _physics_process(delta):
	if typeof(target) != 0: #if target node present follow it
		speed = MOVE_SPEED
		idle_timer.paused = true
		dynamic_move()
	elif path.size() != 0: #if no target node, dont create new path and finish walking path
		idle_timer.paused = true
		finish_move()
	else: #if no target and nowhere left to go activate idle movement
		idle_timer.paused = false
		return
	
	for i in get_slide_count(): #if collision with door - open it
		var collision = get_slide_collision(i).collider
		#if collision while idle moving, stop and clear array to avoid issues
		if collision.is_in_group("security_doors"):
			path.resize(0)
		elif collision.is_in_group("doors"):
			open_door(collision)
		elif speed == IDLE_SPEED:
			path.resize(0)
		#if (path.size() != 0 and speed == IDLE_SPEED) or collision.is_in_group("security_doors"):
		#	path.resize(0)
		#elif collision.is_in_group("doors"):
		#	open_door(collision)
	
	# DEBUG STUFF #
	if settings.debug_mode: #if in debug mode then show the pathfinding vectors
		var debug_path = PoolVector2Array()
		for i in path:
			debug_path.append(to_local(i))
		pathfinding.points = debug_path

func _on_IdleTimer_timeout(): #crude idle movement implementation
	idle_timer.wait_time = rand_range(2,8)
	var x = rand_range(-1,1) * IDLE_DISTANCE
	var y = rand_range(-1,1) * sqrt(pow(IDLE_DISTANCE,2) - pow(x,2))
	path = nav.get_simple_path(position, position + Vector2(x,y))
	speed = IDLE_SPEED
