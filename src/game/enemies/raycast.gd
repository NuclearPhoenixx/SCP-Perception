extends RayCast2D

onready var myself = get_parent()
var target

func _on_TargetArea_body_entered(body):
	if body.is_in_group("player"):
		target = body
		enabled = true

func _on_TargetArea_body_exited(body):
	if body.is_in_group("player"):
		enabled = false

func _physics_process(delta):
	if enabled:
		cast_to = to_local(target.position)
		
		if get_collider() == target:
			myself.target = target
			#play scary running sound
		else:
			myself.target = null
		
		update()

func _draw():
	if settings.debug_mode: #if in debug mode, draw target
		draw_circle(cast_to, 5, Color(1,0,0,1))
