extends Node2D

##In degrees per second
@export var rotation_speed : float = 1000

func _process(delta: float) -> void:
	rotate(deg_to_rad(rotation_speed*delta))
