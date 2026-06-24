extends Area2D

@export var nodes_to_reveal : Array[CanvasItem]
@export var nodes_to_hide : Array[CanvasItem]

func _ready() -> void:
	for node in nodes_to_reveal:
		_init_visual(node)
	
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

func _init_visual(node : CanvasItem):
	node.modulate.a = 0.0
	node.show()

func _on_area_entered(area2d : Area2D):
	for node in nodes_to_reveal:
		_transition(node, Color.WHITE)
		
	for node in nodes_to_hide:
		_transition(node, Color.TRANSPARENT)

func _on_area_exited(area2d : Area2D):
	for node in nodes_to_reveal:
		_transition(node, Color.TRANSPARENT)
	
	for node in nodes_to_hide:
		node.show()
		_transition(node, Color.WHITE)

func _transition(node : CanvasItem, color : Color):
	node.create_tween().tween_property(node, "modulate", color, 1.0)
	
