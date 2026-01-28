extends VisibleOnScreenNotifier2D

@export var camera : Camera2D

@export var limit_top : int = -10000000
@export var limit_bottom : int = 10000000

func _ready() -> void:
	screen_entered.connect(_set_camera_bounds)

func _set_camera_bounds():
	camera.create_tween().tween_property(camera, "limit_top", limit_top, 1.0)
	camera.create_tween().tween_property(camera, "limit_bottom", limit_bottom, 1.0)
	#camera.limit_top = limit_top
	#camera.limit_bottom = limit_bottom
