extends KinematicBody2D

onready var nav = get_tree().get_root().find_node("Navigation", true, false)
onready var pathfinding = get_node("DebugPathfinding")
onready var idle_timer = get_node("IdleTimer")

var SPEED = 80
var IDLE_DISTANCE = 120
var target = null
var path = PoolVector2Array()
var idle_move = false

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
		idle_timer.paused = true
		dynamic_move()
	elif path.size() != 0: #if no target node, dont create new path and finish walking path
		idle_timer.paused = true
		finish_move()
	else: #if no target and nowhere left to go activate idle movement
		idle_timer.paused = false
	
	for i in get_slide_count(): #if collision with door - open it
		var collision = get_slide_collision(i).collider
		if collision.is_in_group("doors"):
			open_door(collision)
		elif idle_move: #if collision while idle moving, clear array to avoid issues
			idle_move = false
			path.remove(0)
	
	# DEBUG STUFF
	if settings.debug_mode: #if in debug mode then show the pathfinding vectors
		var debug_path = PoolVector2Array()
		for i in path:
			debug_path.append(to_local(i))
		pathfinding.points = debug_path

func _on_IdleTimer_timeout(): #crude idle movement code. Can be improved to be more intelligent
	idle_timer.wait_time = rand_range(2,8)
	var x = rand_range(-120,120)
	var y = rand_range(-1,1) * sqrt(pow(IDLE_DISTANCE,2) - pow(x,2))
	path.append(position + Vector2(x,y))
	idle_move = true
