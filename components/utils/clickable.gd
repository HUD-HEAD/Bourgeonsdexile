extends Area2D

func _ready() -> void:
	#Signal to change cursor when hovering in area
	mouse_entered.connect(SignalManager.set_cursor_shape.emit.bind(Input.CURSOR_POINTING_HAND))
	mouse_exited.connect(SignalManager.set_cursor_shape.emit.bind(Input.CURSOR_ARROW))
	
	input_event.connect(_on_area_2d_input_event)

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("select_element"):
		_action_on_click()

func _action_on_click():
	#print("clicked!")
	hide()
