extends Node2D

## NOTE, TASK : Could be replaced with script on Brush,
## but need to account for position computation differences

@export var brush : Sprite2D

func _ready() -> void:
	brush.hide()
	set_process(false)
	
func _process(delta: float) -> void:
	brush.global_position = get_global_mouse_position()
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("select_element"):
		set_process(true)
		brush.show()
	elif event.is_action_released("select_element"):
		brush.hide()
		set_process(false)
		
	
