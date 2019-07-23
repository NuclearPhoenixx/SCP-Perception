extends KinematicBody2D

onready var SoundPlayer = get_node("PlayerSound")
onready var SoundTimer = SoundPlayer.get_node("Timer")

var inv_visible = false

func move(direction):
	var speed
	
	if Input.is_action_pressed("sprint") and !game.player_data["exhausted"]: #sprint if not exhausted
		speed = game.SPRINT_SPEED
		move_sound(sound.sprint, sound.SPRINT_DELAY) #play sprint sound
	else:
		speed = game.WALK_SPEED
		move_sound(sound.walk, sound.WALK_DELAY) #play walk sound
	
	if abs(direction.angle_to(get_global_mouse_position() - position)) > game.WALK_BACK_ANGLE:
		speed *= game.WALK_BACK_FACTOR
		#move_sound(sound.walk, sound.WBACK_DELAY) #WALK BACK SOUND?
	
	move_and_slide(direction * speed)

""" #Better way of doing this, however, this makes movement really choppy. Why?
var velocity = Vector2()
	if Input.is_action_pressed("game_up"): # basic movement
		get_tree().set_input_as_handled()
		velocity.y -= 1
	if Input.is_action_pressed("game_down"):
		get_tree().set_input_as_handled()
		velocity.y += 1
	if Input.is_action_pressed("game_left"):
		get_tree().set_input_as_handled()
		velocity.x -= 1
	if Input.is_action_pressed("game_right"):
		get_tree().set_input_as_handled()
		velocity.x += 1
	
	if velocity.length() != 0:
		move(velocity.normalized())
	
	look_at(get_global_mouse_position()) # rotate head to mouse position
"""

func _physics_process(delta):
	if Input.is_action_pressed("game_up"): # basic movement
		get_tree().set_input_as_handled()
		move(Vector2(0,-1))
	if Input.is_action_pressed("game_down"):
		get_tree().set_input_as_handled()
		move(Vector2(0,1))
	if Input.is_action_pressed("game_left"):
		get_tree().set_input_as_handled()
		move(Vector2(-1,0))
	if Input.is_action_pressed("game_right"):
		get_tree().set_input_as_handled()
		move(Vector2(1,0))
	
	if !inv_visible:
		look_at(get_global_mouse_position()) # rotate head to mouse position

func _unhandled_key_input(event):
	if event.is_action_pressed("inventory"): #if inventory visible
		get_tree().set_input_as_handled()
		inv_visible = !inv_visible

func move_sound(stream, delay): #sound handling
	if !SoundPlayer.is_playing() and SoundTimer.is_stopped():
		SoundPlayer.stream = stream[round(rand_range(0,7))]
		SoundTimer.start(delay)

func _on_Timer_timeout():
	SoundPlayer.play()
	SoundTimer.stop()
