extends Area2D

var dragging : bool = false

func _ready() -> void:
	#TODO Refactor all interactables?
	#Signal to change cursor when hovering in area
	mouse_entered.connect(SignalManager.set_cursor_shape.emit.bind(Input.CURSOR_POINTING_HAND))
	mouse_exited.connect(_on_mouse_exited)

	input_event.connect(_on_area_2d_input_event)

func _process(delta: float) -> void:
	if dragging:
		move_to_pos(get_viewport().get_mouse_position())
		


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("select_element"):
		_action_on_click()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("select_element"):
		dragging = false
		input_pickable = true

func _action_on_click():
	print("clicked!")
	dragging = true
	input_pickable = false
	SignalManager.set_cursor_shape.emit(Input.CURSOR_MOVE)


func move_to_pos(g_pos: Vector2) -> void:
	global_position = lerp(global_position, g_pos, 0.5)

func _on_mouse_exited():
	#While dragging, mouse might exit area, but cursor should stay holding
	if !dragging:
		SignalManager.set_cursor_shape.emit(Input.CURSOR_ARROW)
