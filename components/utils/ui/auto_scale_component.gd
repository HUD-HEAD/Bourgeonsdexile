extends Control

@export_range(0.5, 2, 0.01) var scale_multiplier: float = 1.1
var original_scale: Vector2 

func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	original_scale = scale
	
func _on_mouse_entered():
	scale = original_scale * scale_multiplier

func _on_mouse_exited():
	scale = original_scale
