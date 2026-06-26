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
	return _is_correct_rotation() && placement_checker.is_correctly_placed()

#NOTICE tried using is_equal_approx with rotation float values (both degrees and radians), did not yield consitent results
## Check if current rotation is equal to correct rotation
func _is_correct_rotation() -> bool:
	##Convert current rotation to integer in range [0;360[
	var curr_rot : int = posmod(roundi(draggable.global_rotation_degrees),360)
	var equal_rotation : bool = curr_rot == correct_rotation
	
	#print(curr_rot, " int ", correct_rotation)
	#print(equal_rotation)
	
	return equal_rotation
	
## Rotate piece and check placement
func rotate_custom(offset_degrees : float):
	#Using rotate func keeps value wrapped
	draggable.rotate(deg_to_rad(offset_degrees))
	
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
	draggable.global_rotation_degrees = correct_rotation
