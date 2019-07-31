extends KinematicBody2D

onready var Nav = get_tree().get_root().find_node("Navigation", true, false)
onready var Pathfinding = get_node("DebugPathfinding")
onready var IdleTimer = get_node("IdleTimer")
onready var Raycast = get_node("RayCastTarget")
onready var cs_radius = get_node("CollisionShape").shape.radius #collision shape radius

export(float) var MOVE_SPEED = 90
export(float) var STUCK_THRES = .01
export(float) var IDLE_SPEED = 40
export(float) var IDLE_DISTANCE = 120
export(float, 1, 60) var IDLE_TIME_MIN = 4
export(float, 1, 60) var IDLE_TIME_MAX = 12

var speed = MOVE_SPEED #current moving speed
var path = PoolVector2Array()

func create_path(pos):
	path = Nav.get_simple_path(position, pos)
	#look_at(pos)

func move(speed = MOVE_SPEED):
	var distance = path[0] - position
	
	while distance.length() <= cs_radius + .1: #loop through until valid target pos has been found
		path.remove(0)
		if path.size() == 0:
			return
		distance = path[0] - position
	
	move_and_slide(distance.normalized() * speed)
	#look_at(distance)

func open_door(door): #this function will probably kill everybody
	door.door_control()
	print("FBI, open up!")

func _physics_process(delta):
	if Raycast.TargetNode != null: #if target found then stop idle movement and follow target
		IdleTimer.stop()
		speed = MOVE_SPEED
		create_path(Raycast.TargetNode.position)
	
	if path.size() != 0:
		move(speed)
		for i in get_slide_count():
			var collision = get_slide_collision(i)
			var Collider = collision.collider
			if Collider.is_in_group("door") and Collider.door_clearance == 0:
				open_door(Collider)
			elif collision.travel.length() <= STUCK_THRES: #this prevents the scp to get indefinitely stuck
				path.resize(0)
	elif IdleTimer.is_stopped(): #if no path to go start idle movement
		IdleTimer.start(core.rand_int(IDLE_TIME_MIN,IDLE_TIME_MAX))
	
	# DEBUG STUFF #
	if settings.debug_mode: #if in debug mode then show the Pathfinding vectors
		var debug_path = PoolVector2Array()
		for i in path:
			debug_path.append(to_local(i))
		Pathfinding.points = debug_path

func _on_IdleTimer_timeout(): #crude idle movement implementation
	var idle_target = Vector2()
	idle_target.x = core.rand_int(-IDLE_DISTANCE, IDLE_DISTANCE)
	idle_target.y = core.rand_int(-IDLE_DISTANCE, IDLE_DISTANCE)
	speed = IDLE_SPEED
	create_path(position + idle_target)

func save():
	var save_dict = {
					"MOVE_SPEED": MOVE_SPEED,
					"STUCK_THRES": STUCK_THRES,
					"IDLE_SPEED": IDLE_SPEED,
					"IDLE_DISTANCE": IDLE_DISTANCE,
					"IDLE_TIME_MIN": IDLE_TIME_MIN,
					"IDLE_TIME_MAX": IDLE_TIME_MAX,
					"speed": speed,
					#"path": path
					}
	return save_dict
