extends VisibleOnScreenNotifier2D
@export var next_scene : PackedScene

func _ready() -> void:
	screen_entered.connect(_on_screen_entered)

func _on_screen_entered():
		SceneManager.goto_scene(next_scene)
