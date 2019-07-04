extends KinematicBody2D

var current_sprint_speed = game.sprint_speed #on spawn use normal sprint speed

func move():
	var speed = game.walk_speed
	if Input.is_action_pressed("sprint"): # check if player is sprinting
		speed = current_sprint_speed
	
	var move = Vector2(0,-1)
	if settings.follow_mode:
		move = (get_global_mouse_position() - position).normalized()
	
	if Input.is_action_pressed("game_up"): # basic movement
		move_and_slide(move * speed)
	if Input.is_action_pressed("game_down"):
		move_and_slide(move.rotated(PI) * speed)
	if Input.is_action_pressed("game_left"):
		move_and_slide(move.rotated(-PI/2) * speed)
	if Input.is_action_pressed("game_right"):
		move_and_slide(move.rotated(PI/2) * speed)

func _process(delta):
	look_at(get_global_mouse_position()) # rotate head to mouse position
	move() # movement control
