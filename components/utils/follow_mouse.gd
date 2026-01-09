extends AnimatedSprite2D

const SPEED = 500


func _process(delta: float) -> void:
	var target : Vector2 = get_local_mouse_position()
	var offset = target.normalized() * delta * SPEED #Normalize to get direction
	global_position += offset

	flip_h = target.x < 0
