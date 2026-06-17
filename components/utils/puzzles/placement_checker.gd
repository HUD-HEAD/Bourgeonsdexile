@tool
class_name PlacementChecker
extends Area2D

##Assigned in drag_drop_puzzle script
@export var receptacle : Area2D:
	set(_receptacle):
		receptacle = _receptacle
		update_configuration_warnings()

@export var receptacles : Array[Area2D]

var current_receptacle : Area2D


func _ready() -> void:
	input_pickable = false
	
	#TODO run tool receptacles upgrade
	if receptacles.size() < 1:
		receptacles.resize(1)
	receptacles[0] = receptacle

func is_correctly_placed() -> bool:
	for _receptacle in receptacles:
		if _receptacle.occupied == false && overlaps_area(_receptacle):
			current_receptacle = _receptacle
			_receptacle.occupied = true
			return true
	return false

func is_correctly_placed_old() -> bool:
	#TASK assess design, should it support drag and drop without receptacle? Or create overload?
	if receptacle == null:
		return false
	
	return overlaps_area(receptacle)

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
