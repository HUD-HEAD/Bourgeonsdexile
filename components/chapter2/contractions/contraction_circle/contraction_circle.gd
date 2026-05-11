extends Node

var min_radius : float
@export var max_radius : float = 200
@export var growth_factor : float = 3
#HACK 
@export var node_to_enable : Node

@export_group("Nodes")
@export var circle : Circle
@export var handle : Node2D
@export var drag_rotate : DraggableRotate


func _ready() -> void:
	node_to_enable.process_mode = Node.PROCESS_MODE_DISABLED
	min_radius = circle.radius

func _process(delta: float) -> void:
	if drag_rotate.dragging :
		var added_radius = drag_rotate.target_rotation * growth_factor
		circle.radius = clampf(circle.radius + added_radius, min_radius, max_radius)
		
		handle.position.y = circle.radius
		
	if circle.radius >= max_radius:
		disable()

func disable():
	process_mode = Node.PROCESS_MODE_DISABLED
	node_to_enable.process_mode = Node.PROCESS_MODE_INHERIT
	
