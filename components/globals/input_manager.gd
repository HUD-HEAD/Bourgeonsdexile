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
