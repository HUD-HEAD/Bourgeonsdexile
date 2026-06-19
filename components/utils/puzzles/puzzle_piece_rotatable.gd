## A puzzle piece module with components to drag and drop onto a corresponding receptacle
@tool
class_name PuzzlePieceRotatable
extends PuzzlePiece

##Rotation in degrees [0,90,180,270], clockwise, for the puzzle piece to be correct
@export_range(0,270,90) var correct_rotation : int = 0

var rotation_interface : RotationInterface
const GROUP_NAME := "rotatable_pieces"

func _ready() -> void:
	super()
	rotation_interface = preload("uid://cv8g3rds0g3a3").instantiate()
	draggable.add_child(rotation_interface)
	#rotation_interface.move_to_front()
	rotation_interface.connect_piece(self)
	rotation_interface.hide()
	
	#TODO #TASK optimize so not all pieces in scene are in group
	add_to_group(GROUP_NAME)

##Move PuzzlePiece to front (on top of siblings).
func _on_piece_clicked():
	move_to_front()
	get_tree().call_group(GROUP_NAME, "hide_rotation_interface")
	rotation_interface.show()

## Check if correctly placed in receptacle
func is_correctly_placed():
	return draggable.rotation_degrees == correct_rotation && placement_checker.is_correctly_placed()

## Rotate piece and check placement
func rotate_custom(clockwise : bool):
	draggable.rotation_degrees = int(draggable.rotation_degrees+90)%360 if clockwise else int(draggable.rotation_degrees-90)%360
	rotation_interface.global_rotation = 0
	
	_check_placement()

func hide_rotation_interface():
	rotation_interface.hide()

func deactivate():
	super()
	remove_from_group(GROUP_NAME)
	
func enable_piece():
	add_to_group(GROUP_NAME)
