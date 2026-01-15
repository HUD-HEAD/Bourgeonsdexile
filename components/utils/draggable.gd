extends Area2D
class_name Draggable

signal piece_correctly_placed

##Assigned in drag_drop_puzzle script
var receptacle : Area2D

var dragging : bool = false

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
		_action_on_click()
	elif event.is_action_released("select_element"):
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
	#While dragging, mouse might exit area, but cursor should stay holding
	if !dragging:
		SignalManager.set_cursor_shape.emit(Input.CURSOR_ARROW)

func _on_mouse_entered():
	#While dragging, mouse might exit area, but cursor should stay holding
	if !dragging:
		SignalManager.set_cursor_shape.emit(Input.CURSOR_POINTING_HAND)

func _drop():
	SignalManager.set_cursor_shape.emit(Input.CURSOR_POINTING_HAND)
	
	if is_correctly_placed():
		piece_correctly_placed.emit()
		print_debug("puzzle piece correct!")

func is_correctly_placed() -> bool:
	#TASK assess design, should it support drag and drop without receptacle? Or create overload?
	if receptacle == null:
		return false
	return overlaps_area(receptacle)
