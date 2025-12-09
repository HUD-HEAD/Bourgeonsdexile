##Handles visual states of the cursor
extends Node


# Load the custom images for the mouse cursor.
const T_ARROW : Texture2D = preload("res://graphics/ui/cursor/cursor_line/arrow_line.png")
const T_POINTING_HAND : Texture2D = preload("res://graphics/ui/cursor/cursor_line/hand_line.png")
const T_DRAG : Texture2D = preload("res://graphics/ui/cursor/cursor_line/hold_line.png")


func _ready():
	SignalManager.set_cursor_shape.connect(set_cursor_shape)
	
	# Changes only the arrow shape of the cursor.
	# This is similar to changing it in the project settings.
	Input.set_custom_mouse_cursor(T_ARROW)

	# Changes a specific shape of the cursor
	Input.set_custom_mouse_cursor(T_POINTING_HAND, Input.CURSOR_POINTING_HAND)
	Input.set_custom_mouse_cursor(T_DRAG, Input.CURSOR_DRAG)
	Input.set_custom_mouse_cursor(T_DRAG, Input.CURSOR_MOVE)

func set_cursor_shape(shape_idx : int):
		Input.set_default_cursor_shape(shape_idx)
		#print_debug(shape_idx)
	
