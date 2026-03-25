extends Node2D

var camera : Camera2D

func _ready() -> void:
	camera = get_viewport().get_camera_2d()

func _process(delta: float) -> void:
	self.global_position.x = camera.global_position.x
