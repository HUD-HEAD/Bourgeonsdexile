## This script makes it possible to scroll on a 2D element by click and dragging anywhere on the screen.

extends Node2D

@export_category("Scrolling parameters")
@export var lock_x : bool = false
@export var lock_y : bool = false

#Current state
var dragging : bool = false

func _process(delta: float) -> void:
	if dragging:
		var offset = _get_offset()
		self.position += offset

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("select_element"):
		_start_dragging()
	elif event.is_action_released("select_element"):
		_stop_dragging()

## Triggers scrolling behavior
func _start_dragging():
	#Clear accumulated value to prevent jitter
	clear_mouse_movement()
	dragging = true

## Triggers scrolling behavior
func _stop_dragging():
	dragging = false

## Returns offset to apply, taking into account locked axis
func _get_offset() -> Vector2:
	var offset = get_mouse_movement()
	if lock_x:
		offset.x = 0.0
	else:	#Panel should move opposite from mouse drag direction
		offset.x = -offset.x
	if lock_y:
		offset.y = 0.0
	
	return offset



#NOTICE : Local mouse accumulator allows for multiple scrolling components to coexist.
#Could be moved to InputManager if unnecessary
#region Mouse movement tracking

##Accumulator for tracking mouse movement
var mouse_acc : Vector2 = Vector2.ZERO

func _unhandled_input(event) -> void:
	_handle_mouse_movement(event)
	
## Update mouse accumulator, with smoothing
func _handle_mouse_movement(event):
	if event is InputEventMouseMotion :
		var viewport_transform: Transform2D = get_tree().root.get_final_transform()
		var xformed_event = event.xformed_by(viewport_transform).relative
		mouse_acc = mouse_acc.lerp(xformed_event, 0.1)

## Return mouse displacement
func get_mouse_movement() -> Vector2:
	var result = mouse_acc * InputManager.mouse_sensitivity
	clear_mouse_movement()
	return result

func clear_mouse_movement():
	mouse_acc = Vector2.ZERO

#endregion
