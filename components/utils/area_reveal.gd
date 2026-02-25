extends Area2D

@export var node_to_reveal : Node2D
@export var background_mask : CanvasItem

func _ready() -> void:
	_init_visual(node_to_reveal)
	_init_visual(background_mask)
	
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

func _init_visual(node : CanvasItem):
	node.modulate.a = 0.0
	node.show()

func _on_area_entered(area2d : Area2D):
	_transition(node_to_reveal, Color.WHITE)
	_transition(background_mask, Color.WHITE)

func _on_area_exited(area2d : Area2D):
	_transition(node_to_reveal, Color.TRANSPARENT)
	_transition(background_mask, Color.TRANSPARENT)

func _transition(node : CanvasItem, color : Color):
	node.create_tween().tween_property(node, "modulate", color, 1.0)
	
