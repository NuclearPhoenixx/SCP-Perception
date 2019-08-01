extends KinematicBody2D

onready var MoveSound = get_node("MoveSound")
onready var SoundTimer = MoveSound.get_node("Timer")
onready var SoundPlayer = get_node("SoundEffects")

var inv_visible = false
var floor_material = ""

func move(direction):
	var speed
	
	if Input.is_action_pressed("sprint") and !game.player_data["exhausted"]: #sprint if not exhausted
		speed = game.SPRINT_SPEED
		move_sound(sound.get("sprint" + floor_material), sound.SPRINT_DELAY) #play sprint sound
	else:
		speed = game.WALK_SPEED
		move_sound(sound.get("walk" + floor_material), sound.WALK_DELAY) #play walk sound
	
	if abs(direction.angle_to(get_global_mouse_position() - position)) > game.WALK_BACK_ANGLE:
		speed *= game.WALK_BACK_FACTOR
		#move_sound(sound.walk, sound.WBACK_DELAY) #WALK BACK SOUND?
	
	move_and_slide(direction * speed)

func _physics_process(delta):
	#Better/Faster way of doing this (tested), however, this makes movement quite more choppy. Why?
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
	
	"""
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
	"""
	
	if !inv_visible: #only move head if not in inventory
		look_at(get_global_mouse_position()) # rotate head to mouse position

func _unhandled_key_input(event):
	if event.is_action_pressed("inventory"): #if inventory visible
		get_tree().set_input_as_handled()
		inv_visible = !inv_visible

func move_sound(stream, delay): #sound handling
	if !MoveSound.is_playing() and SoundTimer.is_stopped():
		MoveSound.stream = stream[core.rand_int(0,7)]
		SoundTimer.start(delay)

func _on_Timer_timeout():
	MoveSound.play()

func tease_sound(): #this will play when the player spots an enemy
	if !SoundPlayer.is_playing():
		SoundPlayer.stream = sound.spot_sounds[core.rand_int(0,2)]
		SoundPlayer.play()

func scare_sound(): #this will play when the player gets "jump-scared"
	if !SoundPlayer.is_playing():
		SoundPlayer.stream = sound.scare_sounds[core.rand_int(0,3)]
		SoundPlayer.play()
