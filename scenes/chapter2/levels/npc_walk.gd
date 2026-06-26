@tool
extends AnimatedSprite2D

@export var walk_speed : float = 75
@export var go_left : bool = false:
	set(value):
		go_left = value
		flip_h = go_left
		var swap_speed : bool = (go_left && walk_speed > 0) || (!go_left && walk_speed < 0)
		if swap_speed:
			walk_speed = -walk_speed

func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		return
	position.x += walk_speed*delta
