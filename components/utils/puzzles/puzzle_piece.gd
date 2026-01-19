## A puzzle piece module with components to drag and drop onto a corresponding receptacle
@tool
class_name PuzzlePiece
extends Node2D

signal piece_correctly_placed

## Component handling drag and drop
@export var draggable : Draggable:
	set(_draggable):
		draggable = _draggable
		update_configuration_warnings()
		
## Component checking if piece is placed in associated receptacle. Should be a child of Draggable
@export var placement_checker : PlacementChecker:
	set(_placement_checker):
		placement_checker = _placement_checker
		update_configuration_warnings()

func _ready() -> void:
	#Prevent some errors from tool running in editor
	if Engine.is_editor_hint():
		return

	draggable.dropped.connect(_on_piece_dropped)
	
func deactivate():
	draggable.hide()
	draggable.process_mode = Node.PROCESS_MODE_DISABLED	

## If piece dropped in the right place, snap to receptacle position then validate placement
func _on_piece_dropped():
	if placement_checker.is_correctly_placed():
		var tween : Tween = _snap_to_receptacle()
		tween.tween_callback(_validate_placement)

## Signal piece is correctly placed
func _validate_placement():
	print_debug("puzzle piece correct!")
	piece_correctly_placed.emit()

## Snap to receptacle position
func _snap_to_receptacle() -> Tween:
	var tween = get_tree().create_tween()
	tween.tween_property(draggable, "global_position", placement_checker.receptacle.global_position - placement_checker.position, 0.5)	\
		.set_ease(Tween.EASE_OUT)
	return tween

## Check if correctly placed in receptacle
func is_correctly_placed():
	return placement_checker.is_correctly_placed()

## Move puzzle piece to target position and enable interactivity
func activate_piece(gpos : Vector2):

	draggable.global_position = gpos
	draggable.process_mode = Node.PROCESS_MODE_INHERIT
	draggable.show()

#region tooling
func _init() -> void:
	update_configuration_warnings()
	
func _get_configuration_warnings():
	var warnings = []

	if draggable == null:
		warnings.append("Please assign Draggable component.")
	if placement_checker == null:
		warnings.append("Please assign Placement Checker component. Template scene available")

	# Returning an empty array means "no warning".
	return warnings

#endregion
