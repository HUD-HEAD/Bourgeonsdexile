extends Node

var min_radius : float
@export var max_radius : float = 200
@export var growth_factor : float = 3

@export_group("Nodes")
@export var circle : Circle
@export var handle : Node2D
@export var drag_rotate : DraggableRotate


func _ready() -> void:
	min_radius = circle.radius

func _process(delta: float) -> void:
	if drag_rotate.dragging :
		var added_radius = drag_rotate.target_rotation * growth_factor
		#circle.radius = lerpf(circle.radius, circle.radius + added_radius, 1.0)
		circle.radius += added_radius
		
		handle.position.y = circle.radius
		
	if circle.radius >= max_radius:
		disable()

func disable():
	process_mode = Node.PROCESS_MODE_DISABLED
