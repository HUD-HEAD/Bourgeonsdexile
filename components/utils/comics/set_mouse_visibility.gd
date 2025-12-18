extends VisibleOnScreenEnabler2D

@export var show_mouse : bool = false

func _ready() -> void:
	screen_entered.connect(_on_screen_entered)

func _on_screen_entered():
	if show_mouse:
		InputManager.show_mouse()
	else:
		InputManager.hide_mouse()
