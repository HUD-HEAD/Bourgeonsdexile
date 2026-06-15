class_name PanNode extends Node2D

@export var sensitivity : float = 1.0
var pan_left : bool

##X coordinate of this node at the end of panning
@export var final_pos_x : int = 0

#TODO optimize cursor shape signals

func _ready() -> void:
	pan_left =  final_pos_x > position.x
		

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion && Input.is_action_pressed("select_element"):
		SignalManager.set_cursor_shape.emit(Input.CURSOR_MOVE)
		
		if !pan_left :
			#Panning to the right only
			if event.relative.x < 0:
				global_position.x += event.relative.x*sensitivity
		else :
			#Panning to the left only
			if event.relative.x > 0:
				global_position.x += event.relative.x*sensitivity
		
		_check_offset()
		
	else:
		SignalManager.set_cursor_shape.emit(Input.CURSOR_POINTING_HAND)

func _check_offset():
		if !pan_left && position.x <= final_pos_x	\
				or  pan_left && position.x >= final_pos_x:
			_complete()

func _complete():
	set_process_unhandled_input(false)
	SignalManager.set_cursor_shape.emit(Input.CURSOR_POINTING_HAND)
	SignalManager.next_panel.emit()
