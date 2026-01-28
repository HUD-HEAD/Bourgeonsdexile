extends Area2D

@export var node_to_reveal : Node2D

func _ready() -> void:
	node_to_reveal.self_modulate.a = 0.0
	node_to_reveal.show()
	area_entered.connect(_on_area_entered)
	

func _on_area_entered(area2d : Area2D):
	node_to_reveal.create_tween().tween_property(node_to_reveal, "self_modulate.a", 1.0, 3.0)
