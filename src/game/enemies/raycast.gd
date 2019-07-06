extends RayCast2D

onready var myself = get_node("../.")
var target

func _ready():
	pass
	#set_physics_process(false)
	#add_exception(self)

func _on_FOV_body_entered(body):
	#set_physics_process(true)
	target = body
	enabled = true

func _on_FOV_body_exited(body):
	#set_physics_process(false)
	enabled = false

func _physics_process(delta):
	if enabled:
		cast_to = to_local(target.position)
		
		if get_collider() == target:
			myself.target = target
			#play scare sound
		else:
			myself.target = null
		
		update()

func _draw():
	if settings.debug_mode: #if in debug mode, draw target
		draw_circle(cast_to, 5, Color(1,0,0,1))
