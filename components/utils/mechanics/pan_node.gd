class_name PanNode extends Node2D

@export var sensitivity : float = 1.0

#TODO optimize cursor shape signals


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion && Input.is_action_pressed("select_element"):
		SignalManager.set_cursor_shape.emit(Input.CURSOR_MOVE)
		#Panning to the right only
		if event.relative.x < 0:
			global_position.x += event.relative.x*sensitivity
	else:
		SignalManager.set_cursor_shape.emit(Input.CURSOR_POINTING_HAND)
