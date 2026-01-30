## Drag and drop with mouse
extends Clickable
class_name Draggable

signal dropped

## Is true when any piece is being dragged
static var global_dragging : bool = false

## Is true when this piece is being dragged
var dragging : bool = false:
	#Automatically update global dragging when piece is dragged/dropped
	set(value):
		dragging = value
		global_dragging = value

##Keep object offset relative to cursor on click
var offset : Vector2


func _process(delta: float) -> void:
	if dragging:
		move_to_pos(get_global_mouse_position() + offset)

func _unhandled_input(event: InputEvent) -> void:
	if dragging && event.is_action_released("select_element"):
		dragging = false
		_drop()

func _action_on_click():
	offset = global_position - get_global_mouse_position()
	
	dragging = true
	SignalManager.set_cursor_shape.emit(Input.CURSOR_MOVE)


func move_to_pos(g_pos: Vector2) -> void:
	global_position = g_pos

func _on_mouse_exited():
	hovering_count -= 1
	if hovering_count < 1:
		#While dragging any piece, mouse might exit area, but cursor should stay holding
		if !global_dragging:
			SignalManager.set_cursor_shape.emit(Input.CURSOR_ARROW)

func _on_mouse_entered():
	hovering_count += 1
	#While dragging any piece, mouse might enter area, but cursor should stay holding
	if !global_dragging:
		SignalManager.set_cursor_shape.emit(Input.CURSOR_POINTING_HAND)

func _drop():
	SignalManager.set_cursor_shape.emit(Input.CURSOR_POINTING_HAND)
	dropped.emit()
