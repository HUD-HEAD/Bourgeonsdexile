class_name CameraMovement
extends VisibleOnScreenNotifier2D

@export var camera_ref: Camera2D
@export var new_offset: float
@export var transition_time: float


func _ready() -> void:
	self.screen_entered.connect(_center_camera)


func _center_camera():
	var tween = create_tween()
	tween.tween_property(camera_ref, "offset:x", new_offset, transition_time)
	self.screen_entered.disconnect(_center_camera)
