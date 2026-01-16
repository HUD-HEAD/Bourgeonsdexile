class_name PlacementChecker
extends Area2D

##Assigned in drag_drop_puzzle script
@export var receptacle : Area2D

func is_correctly_placed() -> bool:
	#TASK assess design, should it support drag and drop without receptacle? Or create overload?
	if receptacle == null:
		return false
	return overlaps_area(receptacle)
