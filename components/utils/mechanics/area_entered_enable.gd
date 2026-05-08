extends Area2D
@export var node_to_enable : Node

func _ready() -> void:
	node_to_enable.process_mode = Node.PROCESS_MODE_DISABLED
	area_entered.connect(_on_area_entered)

func _on_area_entered(area2d : Area2D):
	node_to_enable.process_mode = Node.PROCESS_MODE_INHERIT
