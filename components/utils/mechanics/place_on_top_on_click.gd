extends Node

@export var nodes_affected : Array[Clickable]

func _ready() -> void:
	for node in nodes_affected:
		node.clicked.connect(_on_clicked.bind(node))
		
		
func _on_clicked(node : Clickable):
	node.move_to_front()
