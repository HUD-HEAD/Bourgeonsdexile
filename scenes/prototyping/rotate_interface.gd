@tool
class_name RotationInterface
extends Node2D

@export var turn_clockwise : BaseButton

func _ready() -> void:
	global_rotation_degrees = 0

func connect_piece(piece : PuzzlePieceRotatable):
	turn_clockwise.pressed.connect(piece.rotate_custom.bind(90.0))

##Prevent scaling
func _notification(what: int) -> void:
	if what == NOTIFICATION_TRANSFORM_CHANGED:
		self.global_scale = Vector2.ONE
		pass
		#TODO debug
		#self.global_rotation = 0
		
