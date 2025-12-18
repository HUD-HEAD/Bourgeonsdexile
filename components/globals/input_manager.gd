extends Node

##How sensitive is mouse movement
var mouse_sensitivity = 1.0

func show_mouse():
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED
	
func hide_mouse():
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
