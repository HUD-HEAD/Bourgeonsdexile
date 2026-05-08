class_name DraggableRotate extends Draggable

var offset_angle : float = 0.0
var target_rotation : float = 0.0

func _process(delta: float) -> void:
	if dragging :
		var target_angle : float = get_angle_to(get_global_mouse_position())
		target_rotation = target_angle-offset_angle
		#look_at(get_global_mouse_position())
		rotate(target_rotation)


func _action_on_click():
	super()
	offset_angle = get_angle_to(get_global_mouse_position())
