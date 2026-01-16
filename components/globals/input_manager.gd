extends Node

##How sensitive is mouse movement
var mouse_sensitivity = 1.0

func show_mouse():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
#TODO remove hiding logic if unused
func hide_mouse():
	#Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
	pass

func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("exit"):
		get_tree().quit()
	
	if OS.has_feature("debug"):
		_debug_inputs(event)
	
#TESTING
func _debug_inputs(event : InputEvent) -> void :
	if event.is_action_pressed("debug_speed_up"):
		Engine.time_scale *= 2
		print_debug("Speed up x", Engine.time_scale)
	if event.is_action_pressed("debug_speed_down"):
		Engine.time_scale /= 2
		print_debug("Speed down x", Engine.time_scale)
