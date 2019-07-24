extends RayCast2D

var AreaTarget
var TargetNode

func _on_RayCastArea_body_entered(body):
	if body.is_in_group("player"):
		AreaTarget = body
		enabled = true

func _on_RayCastArea_body_exited(body):
	if body.is_in_group("player"):
		TargetNode = null
		enabled = false

func _physics_process(delta):
	if enabled:
		cast_to = to_local(AreaTarget.position)
		
		if get_collider() == AreaTarget:
			TargetNode = AreaTarget
			#play scary running sound
		else:
			TargetNode = null
		
		update()

func _draw():
	if settings.debug_mode: #if in debug mode, draw TargetNode
		draw_circle(cast_to, 5, Color(1,0,0,1))
