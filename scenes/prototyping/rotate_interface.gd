@tool
class_name RotationInterface
extends Node2D

@export var turn_clockwise : BaseButton

const SCALE = 1.05
const COLOR_NORMAL = Color(0.867, 0.329, 0.18)
const COLOR_HOVERED = Color(0.953, 0.459, 0.161)

func _ready() -> void:
	turn_clockwise.self_modulate = COLOR_NORMAL
	global_rotation_degrees = 0
	turn_clockwise.mouse_entered.connect(_on_button_entered)
	turn_clockwise.mouse_exited.connect(_on_button_exited)

func connect_piece(piece : PuzzlePieceRotatable):
	turn_clockwise.pressed.connect(piece.rotate_custom.bind(piece.ROTATION_STEP))

func _on_button_entered(_color = COLOR_HOVERED, _scale = SCALE):
	turn_clockwise.scale *= _scale
	turn_clockwise.self_modulate = _color
	
func _on_button_exited(_color = COLOR_NORMAL, _scale = SCALE):
	turn_clockwise.scale /= _scale
	turn_clockwise.self_modulate = _color


##Prevent scaling
func _notification(what: int) -> void:
	if what == NOTIFICATION_TRANSFORM_CHANGED:
		self.global_scale = Vector2.ONE
		pass
		#TODO debug
		#self.global_rotation = 0
		
