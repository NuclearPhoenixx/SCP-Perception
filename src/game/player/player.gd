extends KinematicBody2D

func move(direction):
	var speed = game.walk_speed
	if Input.is_action_pressed("sprint") and !game.player_exhausted: #sprint if not exhausted
		speed = game.sprint_speed
	
	if abs(direction.angle_to(get_global_mouse_position() - position)) > game.walk_back_angle:
		speed *= game.walk_back_factor
	
	move_and_slide(direction * speed)

func _process(delta):
	if Input.is_action_pressed("game_up"): # basic movement
		move(Vector2(0,-1))
	elif Input.is_action_pressed("game_down"):
		move(Vector2(0,1))
	if Input.is_action_pressed("game_left"):
		move(Vector2(-1,0))
	elif Input.is_action_pressed("game_right"):
		move(Vector2(1,0))
	
	look_at(get_global_mouse_position()) # rotate head to mouse position
