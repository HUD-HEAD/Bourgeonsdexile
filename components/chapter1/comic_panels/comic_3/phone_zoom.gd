extends Node2D

@export var zoom_in : Clickable
@export var zoom_out : Clickable

var step : float = 0.5

func _ready() -> void:
	zoom_in.clicked.connect(_on_zoom_in)
	zoom_out.clicked.connect(_on_zoom_out)
	
func _on_zoom_in():
	var new_scale = clampf(scale.x + step, 1.0, 3.0)
	self.scale = Vector2(new_scale, new_scale)

func _on_zoom_out():
	var new_scale = clampf(scale.x - step, 1.0, 3.0)
	self.scale = Vector2(new_scale, new_scale)
