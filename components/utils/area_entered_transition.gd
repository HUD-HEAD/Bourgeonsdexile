extends Area2D

@export var to_disable : Node

func _ready() -> void:
	area_entered.connect(_on_area_entered)


func _on_area_entered(_area2d : Area2D):
	to_disable.disable()
	SignalManager.show_next_button.emit()
