@tool
extends Node2D
class_name Circle

@export var radius : float = 100.0:
	set(value):
		radius = value
		queue_redraw()

func _draw():
	draw_circle(Vector2(0,0), radius, Color.WHITE)
