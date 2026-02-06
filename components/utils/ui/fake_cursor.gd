extends Node2D

@onready var current_cursor : Sprite2D = $Sprite2D

func _ready():
	#Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	
	SignalManager.set_cursor_shape.connect(_set_cursor_shape)
	_set_cursor_shape(Input.CURSOR_ARROW)

func _process(delta: float) -> void:
	global_position = get_global_mouse_position()

func _set_cursor_shape(shape_idx : int):
	match shape_idx:
		Input.CURSOR_POINTING_HAND:
			current_cursor.texture = CustomCursor.T_POINTING_HAND
		Input.CURSOR_DRAG:
			current_cursor.texture = CustomCursor.T_DRAG
		_:
			current_cursor.texture = CustomCursor.T_ARROW
