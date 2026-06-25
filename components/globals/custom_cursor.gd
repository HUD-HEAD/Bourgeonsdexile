##Handles visual states of the cursor
extends Node


# Load the custom images for the mouse cursor.
const T_ARROW : Texture2D = preload("res://graphics/ui/cursor/fullarrow.png")
const T_POINTING_HAND : Texture2D = preload("res://graphics/ui/cursor/pointinghand.png")
const T_DRAG : Texture2D = preload("res://graphics/ui/cursor/dragginghand.png")

var t_arrow_scale : Texture2D
var t_pointing_hand_scale : Texture2D
var t_drag_scale : Texture2D
var cursor_scale: float = 1

func _ready():
	SignalManager.set_cursor_shape.connect(set_cursor_shape)
	
	_set_custom_mouse_cursor()


func set_cursor_shape(shape_idx : int):
		Input.set_default_cursor_shape(shape_idx)
		#print_debug(shape_idx)
		

func update_cursor_scale (new_scale: float):
	cursor_scale = new_scale
	_set_custom_mouse_cursor()

func _set_custom_mouse_cursor():
	#generate new cursor images with the actual scale
	
	t_arrow_scale = _resize_cursor_texture(T_ARROW)
	t_pointing_hand_scale = _resize_cursor_texture(T_POINTING_HAND)
	t_drag_scale = _resize_cursor_texture(T_DRAG)
	
	# Changes only the arrow shape of the cursor.
	# This is similar to changing it in the project settings.
	Input.set_custom_mouse_cursor(t_arrow_scale)

	# Changes a specific shape of the cursor
	Input.set_custom_mouse_cursor(t_pointing_hand_scale, Input.CURSOR_POINTING_HAND, Vector2(20,0))
	Input.set_custom_mouse_cursor(t_drag_scale, Input.CURSOR_DRAG)
	Input.set_custom_mouse_cursor(t_drag_scale, Input.CURSOR_MOVE)

func _resize_cursor_texture(original_texture: Texture2D) -> Texture2D:
	var actual_size: Vector2 = original_texture.get_size()
	var new_size: Vector2 = actual_size * cursor_scale
	
	var scale_image = original_texture.get_image()
	scale_image.resize(new_size.x, new_size.y, Image.INTERPOLATE_LANCZOS)
	
	var new_texture: Texture2D = ImageTexture.create_from_image(scale_image)
	return new_texture
	
