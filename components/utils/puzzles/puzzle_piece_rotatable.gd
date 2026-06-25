## A puzzle piece module with components to drag and drop onto a corresponding receptacle
@tool
class_name PuzzlePieceRotatable
extends PuzzlePiece

const ROTATION_STEP : int = 90

##Rotation in degrees [0,90,180,270], clockwise, for the puzzle piece to be correct
@export_range(0,270,ROTATION_STEP) var correct_rotation : int = 0

var rotation_interface : RotationInterface
const GROUP_NAME := "rotatable_pieces"

func _ready() -> void:
	super()
	
	#TODO optimize
	#WARNING if initial rotation < 0 degrees, piece will not validate
	_initial_snap_rotation()
	
	rotation_interface = preload("uid://cv8g3rds0g3a3").instantiate()
	draggable.add_child(rotation_interface)
	#rotation_interface.move_to_front()
	rotation_interface.connect_piece(self)
	rotation_interface.hide()
	
	#TODO #TASK optimize so not all pieces in scene are in group
	add_to_group(GROUP_NAME)

##Make sure initial rotation is an increment of 90
func _initial_snap_rotation():
	var _snapped_rotation : float =  snappedf(global_rotation_degrees, ROTATION_STEP)

	#TODO correct modulo
	#print(self.name)
	#var _snapped_rotation : float =  fposmod(snappedf(global_rotation_degrees, ROTATION_STEP),360.0)
	#print(global_rotation_degrees," snapped ", _snapped_rotation)
	#print(global_rotation," snapped rad ",deg_to_rad(_snapped_rotation))
	
	self.global_rotation_degrees = _snapped_rotation
	draggable.rotation_degrees = 0

##Move PuzzlePiece to front (on top of siblings).
func _on_piece_clicked():
	super()
	get_tree().call_group(GROUP_NAME, "hide_rotation_interface")
	rotation_interface.show()

## Check if correctly placed in receptacle
func is_correctly_placed():
	#print(is_equal_approx(draggable.global_rotation_degrees, correct_rotation))
	#print(placement_checker.is_correctly_placed())
	
	##Need to use is_equal_approx, otherwise imprecision leads to initially rotated pieces not being validated
	return is_equal_approx(draggable.global_rotation_degrees, correct_rotation) && placement_checker.is_correctly_placed()

## Rotate piece and check placement
func rotate_custom(offset_degrees : float):
	draggable.rotation_degrees = int(draggable.rotation_degrees+offset_degrees)%360
	rotation_interface.global_rotation = 0
	
	_check_placement()

func hide_rotation_interface():
	rotation_interface.hide()

func deactivate():
	super()
	remove_from_group(GROUP_NAME)
	
func enable_piece():
	super()
	add_to_group(GROUP_NAME)

func autosolve():
	super()
	global_rotation_degrees = correct_rotation
