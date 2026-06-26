extends Node

var camera : Camera2D

func _ready() -> void:
	camera = get_viewport().get_camera_2d()
	SignalManager.adjust_camera.connect(adjust_camera)

#HACK null default
func adjust_camera(_new_offset = null):
	if _new_offset == null:
		_new_offset = -camera.offset.x

	var tween : Tween = get_tree().create_tween()
	tween.tween_property(camera, "offset:x", _new_offset, 5.0)
