extends Clickable

@export var target_scene : PackedScene

func _action_on_click():
	SceneManager.goto_scene(target_scene)
