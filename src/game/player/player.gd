extends KinematicBody2D

onready var stamina_bar = get_tree().get_root().find_node("Stamina", true, false)

func move(direction):
	var speed = game.WALK_SPEED
	if Input.is_action_pressed("sprint") and !stamina_bar.player_exhausted: #sprint if not exhausted
		speed = game.SPRINT_SPEED
	
	if abs(direction.angle_to(get_global_mouse_position() - position)) > game.WALK_BACK_ANGLE:
		speed *= game.WALK_BACK_FACTOR
	
	move_and_slide(direction * speed)

func _process(delta):
	if Input.is_action_pressed("game_up"): # basic movement
		get_tree().set_input_as_handled()
		move(Vector2(0,-1))
	elif Input.is_action_pressed("game_down"):
		get_tree().set_input_as_handled()
		move(Vector2(0,1))
	if Input.is_action_pressed("game_left"):
		get_tree().set_input_as_handled()
		move(Vector2(-1,0))
	elif Input.is_action_pressed("game_right"):
		get_tree().set_input_as_handled()
		move(Vector2(1,0))
	
	look_at(get_global_mouse_position()) # rotate head to mouse position
