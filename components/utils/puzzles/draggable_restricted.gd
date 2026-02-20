extends Draggable
class_name DraggableRestricted

@export_group("Restrict Movement")
@export var left : float
@export var right : float
@export var up : float
@export var down : float

## Original position from which restricted movement is applied
@onready var origin_pos : Vector2 = global_position


func move_to_pos(g_pos: Vector2) -> void:
	var new_pos : Vector2 = g_pos
	new_pos.x = clampf(new_pos.x, origin_pos.x + left, origin_pos.x + right)
	new_pos.y = clampf(new_pos.y, origin_pos.y + up, origin_pos.y + down)
	
	super(new_pos)
