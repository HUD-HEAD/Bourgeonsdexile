@tool
class_name PlacementChecker
extends Area2D

@export var receptacles : Array[Area2D]

var current_receptacle : Area2D


func _ready() -> void:
	input_pickable = false

func is_correctly_placed() -> bool:
	current_receptacle = null
	
	for _receptacle in receptacles:
		if _receptacle.occupied == false && overlaps_area(_receptacle):
			current_receptacle = _receptacle
			_receptacle.occupied = true
			return true
	return false
