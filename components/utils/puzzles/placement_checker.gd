@tool
class_name PlacementChecker
extends Area2D

##Assigned in drag_drop_puzzle script
@export var receptacle : Area2D:
	set(_receptacle):
		receptacle = _receptacle
		update_configuration_warnings()


func _ready() -> void:
	input_pickable = false

func is_correctly_placed() -> bool:
	#TASK assess design, should it support drag and drop without receptacle? Or create overload?
	if receptacle == null:
		return false
		
	var test = overlaps_area(receptacle)
	print_debug(test)
	return test
	#return overlaps_area(receptacle)

#region tooling
func _init() -> void:
	update_configuration_warnings()
	
func _get_configuration_warnings():
	var warnings = []

	if receptacle == null:
		warnings.append("Please assign receptacle component.")

	# Returning an empty array means "no warning".
	return warnings

#endregion
