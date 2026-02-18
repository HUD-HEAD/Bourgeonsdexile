class_name Clickable
extends Area2D

signal clicked

##Account for overlapping areas to prevent cursor change when exiting one area but still within other
static var hovering_count = 0

func _ready() -> void:
	#Signal to change cursor when hovering in area
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	
	input_event.connect(_on_area_2d_input_event)

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("select_element"):
		_action_on_click()

func _action_on_click():
	#print("clicked!")
	clicked.emit()
	
func disable():
	input_pickable = false
	
func enable():
	input_pickable = true
	
func _on_mouse_entered():
	hovering_count += 1
	SignalManager.set_cursor_shape.emit(Input.CURSOR_POINTING_HAND)
	
func _on_mouse_exited():
	hovering_count -= 1
	if hovering_count < 1:
		SignalManager.set_cursor_shape.emit(Input.CURSOR_ARROW)
	
