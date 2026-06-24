@tool
extends Node2D
class_name Circle

@export var radius : float = 100.0:
	set(value):
		radius = value
		queue_redraw()
		
@export var filled : bool = true:
	set(value):
		filled = value
		queue_redraw()
		
@export var width : float = 0:
	set(value):
		width = value
		queue_redraw()

func _draw():
	var _actual_width : float = -1.0 if filled else width
	draw_circle(Vector2(0,0), radius, Color.WHITE, filled, _actual_width, true)
