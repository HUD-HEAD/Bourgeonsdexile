extends VisibleOnScreenNotifier2D

@export var warp_target : Vector2 = Vector2(50, 1080/2)

func _ready() -> void:
	screen_entered.connect(_on_screen_entered)

func _on_screen_entered():
	Input.warp_mouse(warp_target)
