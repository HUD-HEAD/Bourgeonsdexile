extends Node2D

@export var zoom_in : Clickable
@export var zoom_out : Clickable
@export var min_map_scale: float = 1
@export var max_map_scale: float = 3

var step : float = 0.5

func _ready() -> void:
	zoom_in.clicked.connect(_on_zoom_in)
	zoom_out.clicked.connect(_on_zoom_out)
	
func _on_zoom_in():
	var new_scale = clampf(scale.x + step, min_map_scale, max_map_scale)
	self.scale = Vector2(new_scale, new_scale)

func _on_zoom_out():
	var new_scale = clampf(scale.x - step, min_map_scale, max_map_scale)
	self.scale = Vector2(new_scale, new_scale)
