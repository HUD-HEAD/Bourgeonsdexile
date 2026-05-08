extends AnimatedSprite2D

const SPEED = 500


func _process(delta: float) -> void:
	global_position = global_position.move_toward(get_global_mouse_position(), delta*SPEED)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if event.relative.x < 0 &&  get_local_mouse_position().x < 0:
			flip_h = true
		elif event.relative.x > 0 &&  get_local_mouse_position().x > 0:
			flip_h = false
			
