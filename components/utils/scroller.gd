## This script makes it possible to scroll on a 2D element by click and dragging anywhere on the screen.
## #WARNING : With current implementation, only 1 scroller per scene will be functional

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
	InputManager.clear_mouse_movement()
	dragging = true

## Triggers scrolling behavior
func _stop_dragging():
	dragging = false

## Returns offset to apply, taking into account locked axis
func _get_offset() -> Vector2:
	var offset = InputManager.get_mouse_movement()
	if lock_x:
		offset.x = 0.0
	if lock_y:
		offset.y = 0.0
	
	return offset
