extends Node2D

@export var enable_x : bool = true
@export var enable_y : bool = false

var camera : Camera2D

func _ready() -> void:
	camera = get_viewport().get_camera_2d()

func _process(delta: float) -> void:
	var new_gpos : Vector2 = camera.global_position
	if enable_x:
		new_gpos.x = self.global_position.x
	if enable_y:
		new_gpos.y = self.global_position.y
	camera.global_position = new_gpos
