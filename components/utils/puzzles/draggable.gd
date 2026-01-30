## Drag and drop with mouse
extends Area2D
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

func _ready() -> void:
	#assert(receptacle != null)
	
	#TODO Refactor all interactables?
	#Signal to change cursor when hovering in area
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

	input_event.connect(_on_area_2d_input_event)
	

func _process(delta: float) -> void:
	if dragging:
		move_to_pos(get_global_mouse_position() + offset)


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("select_element"):
		#Prevent multiple pieces picked up at once
		if !global_dragging:
			_action_on_click()


func _unhandled_input(event: InputEvent) -> void:
	if dragging && event.is_action_released("select_element"):
		dragging = false
		_drop()

func _action_on_click():
	offset = global_position - get_global_mouse_position()
	
	dragging = true
	SignalManager.set_cursor_shape.emit(Input.CURSOR_MOVE)


func move_to_pos(g_pos: Vector2) -> void:
	#global_position = lerp(global_position, g_pos, 0.5)
	global_position = g_pos

func _on_mouse_exited():
	#While dragging any piece, mouse might exit area, but cursor should stay holding
	if !global_dragging:
		SignalManager.set_cursor_shape.emit(Input.CURSOR_ARROW)

func _on_mouse_entered():
	#While dragging any piece, mouse might enter area, but cursor should stay holding
	if !global_dragging:
		SignalManager.set_cursor_shape.emit(Input.CURSOR_POINTING_HAND)

func _drop():
	SignalManager.set_cursor_shape.emit(Input.CURSOR_POINTING_HAND)
	dropped.emit()

func disable():
	input_pickable = false
